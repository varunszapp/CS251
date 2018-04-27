#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <string.h>
#include <pthread.h>
#include <math.h>

#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s {acc.file} {txn.file} {#oftransactions} {#ofthreads} \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

double a[10000];

typedef struct transaction_details{
	int seq_no;
	int type;
	double amount;
	int ac_1;
	int ac_2;
	int txn_status;
} txn;

	struct thread_param{
	pthread_t tid;
	//double *array;
	int size;
	int skip;
	int thread_ctr;                  
};

txn *txn_array;
short lock_status[10000];

void* do_txn(void *arg){
	struct thread_param *param = (struct thread_param *) arg;
    int ctr = param->thread_ctr;
    int num_jobs=0;
    while(ctr<param->size)
    {
    	num_jobs++;
    	ctr+=param->skip;
    }
    ctr=param->thread_ctr;
    int j=0;
    while(j<num_jobs)
    {   	
    	if((txn_array+ctr)->txn_status==0){
    		switch ((txn_array+ctr)->type)
    		{
    			case 1:
    				if(lock_status[(txn_array+ctr)->ac_1-1001]==0)
    				{	
    					lock_status[(txn_array+ctr)->ac_1-1001]=1;
    					a[(txn_array+ctr)->ac_1-1001]+=(txn_array+ctr)->amount*(0.99);
    					j++;
    					(txn_array+ctr)->txn_status=1;
    					lock_status[(txn_array+ctr)->ac_1-1001]=0;
    				}	
    				break;
    			case 2:
    				if(lock_status[(txn_array+ctr)->ac_1-1001]==0)
    				{	
    					lock_status[(txn_array+ctr)->ac_1-1001]=1;
    					a[(txn_array+ctr)->ac_1-1001]-=(txn_array+ctr)->amount*(1.01);
    					j++;
    					(txn_array+ctr)->txn_status=1;
    					lock_status[(txn_array+ctr)->ac_1-1001]=0;
    				}
    				break;
    			case 3:
    				if(lock_status[(txn_array+ctr)->ac_1-1001]==0)
    				{
						lock_status[(txn_array+ctr)->ac_1-1001]=1;
    					a[(txn_array+ctr)->ac_1-1001]*=1.071;
    					j++;
    					(txn_array+ctr)->txn_status=1;
    					lock_status[(txn_array+ctr)->ac_1-1001]=0;    					
    				}
    				break;
    			case 4:
    				if(lock_status[(txn_array+ctr)->ac_1-1001]==0&&lock_status[(txn_array+ctr)->ac_2-1001]==0)	
    				{
    					lock_status[(txn_array+ctr)->ac_1-1001]=1;
    					lock_status[(txn_array+ctr)->ac_2-1001]=1;
    					a[(txn_array+ctr)->ac_1-1001]-=(txn_array+ctr)->amount;
    					a[(txn_array+ctr)->ac_2-1001]+=(txn_array+ctr)->amount;
    					a[(txn_array+ctr)->ac_1-1001]-=((txn_array+ctr)->amount)*0.01;
    					a[(txn_array+ctr)->ac_2-1001]-=((txn_array+ctr)->amount)*0.01;
    					j++;
    					(txn_array+ctr)->txn_status=1;
    					lock_status[(txn_array+ctr)->ac_1-1001]=0;
    					lock_status[(txn_array+ctr)->ac_2-1001]=0;	
    				}
    				break;				
    		}
    	}		
    	ctr+=param->skip;
    	if(ctr>=param->size)
    		ctr=param->thread_ctr;	
    }
    return NULL;
}


int main(int argc, char *argv[]){
	FILE *acc_file,*txn_file;
	int no_of_threads,no_of_txns;
	struct thread_param *params;
	struct timeval start, end;

	if(argc !=5)
           USAGE_EXIT("not enough parameters");

  	no_of_txns = atoi(argv[3]);
  	if(no_of_txns <=0)
          USAGE_EXIT("invalid num_txns");

    txn_array=(txn*)malloc(no_of_txns*sizeof(txn));
  	
  	no_of_threads = atoi(argv[4]);
  	if(no_of_threads <=0 || no_of_threads > MAX_THREADS){
          USAGE_EXIT("invalid num of threads");
  		}

  	acc_file=fopen(argv[1],"r");
  	if (acc_file==NULL)
    {
        printf("no such account file.");
        return 0;
    }	

    for(int j=0;j<10000;j++)
    {	
    	int i;
    	fscanf(acc_file,"%d",&i);
        fscanf(acc_file,"%lf",&a[i-1001]);
        lock_status[i-1001]=0;
        //printf("%d\n",lock_status[i-1001]);		       // acc 1001 is stored in a[0] so acc i is stored in a[i-1001] 
    	//printf("bal of ac[%d]=%lf\n",i,a[i-1001]);
    }

    txn_file=fopen(argv[2],"r");
  	if (txn_file==NULL)
    {
        printf("no such txn file.");
        return 0;
    }

    for(int j=0;j<no_of_txns;j++)
    {
    	fscanf(txn_file,"%d %d %lf %d %d",&((txn_array+j)->seq_no),&((txn_array+j)->type),&((txn_array+j)->amount),&((txn_array+j)->ac_1),&((txn_array+j)->ac_2));
    	(txn_array+j)->txn_status=0;
    	//printf("%d %d %lf %d %d \n",((txn_array+j)->seq_no),((txn_array+j)->type),((txn_array+j)->amount),((txn_array+j)->ac_1),((txn_array+j)->ac_2));
    }	

    params = malloc(no_of_threads * sizeof(struct thread_param));
 	bzero(params, no_of_threads * sizeof(struct thread_param));

 	gettimeofday(&start, NULL);

/* 	params->size=no_of_txns;
 	params->skip=no_of_threads;
 	params->thread_ctr=0;*/
 //	do_txn(params);

  	/*Partion data and create threads*/      
  	for(int ctr=0; ctr < no_of_threads; ++ctr){
        struct thread_param *param = params + ctr;
        param->size = no_of_txns;
        param->skip = no_of_threads;
      //  param->array = a;
        param->thread_ctr = ctr;
        
        if(pthread_create(&param->tid, NULL, do_txn, param) != 0){
              perror("pthread_create");
              exit(-1);
        }
    }
    for(int ctr=0; ctr < no_of_threads; ++ctr){
        struct thread_param *param = params + ctr;
        pthread_join(param->tid, NULL);
  	}

  	for(int ctr=0;ctr<10000;ctr++)
  	{
  		printf("%d %.2lf\n",ctr+1001,a[ctr]);
  	}
  	gettimeofday(&end, NULL);
  	printf("Time taken = %ld microsecs\n", TDIFF(start, end));
  	free(params);
    return 0;
} 