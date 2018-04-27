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
typedef struct transaction_details{
	int seq_no;
	int type;
	double amount;
	int ac_1;
	int ac_2;
	//int txn_status;
	} txn;

pthread_t thread[64];
int g=0;
double a[10000];
txn *txn_array;
short lock_status[10000];
int no_of_threads,no_of_txns;
pthread_mutex_t lock;


void* do_txn(void *arg){
  int acc_1;
  int acc_2;
  int ctr;
    while(1){
        if(g>no_of_txns-1) return NULL;
        if( (lock_status[(txn_array+g)->ac_1-1001])==0 &&( (txn_array+g)->ac_2==0 || (lock_status[(txn_array+g)->ac_2-1001])==0 ) ){
	      
        pthread_mutex_lock(&lock);
        if( (lock_status[(txn_array+g)->ac_1-1001])==0 &&( (txn_array+g)->ac_2==0 || (lock_status[(txn_array+g)->ac_2-1001])==0 ) ){ 
          if(g>no_of_txns-1) {
            pthread_mutex_unlock(&lock);
            return NULL;
             } 
          ctr=g;
          g++;
          acc_1=(txn_array+ctr)->ac_1-1001;
          lock_status[acc_1]=1;
          if((txn_array+ctr)->type==4){
            acc_2=(txn_array+ctr)->ac_2-1001;
            lock_status[acc_2]=1;
          }
          pthread_mutex_unlock(&lock);
        }

        else{
          pthread_mutex_unlock(&lock);  
          continue;    
        }
          
        

       
        		switch ((txn_array+ctr)->type)
            		{
            			case 1:
            					a[acc_1]+=(txn_array+ctr)->amount*(0.99);
            					lock_status[acc_1]=0;	
            				break;
            			case 2:
            					a[acc_1]-=(txn_array+ctr)->amount*(1.01);
            					lock_status[acc_1]=0;
            				break;
            			case 3:
            					a[acc_1]*=1.071;
            					lock_status[acc_1]=0;    					
            				break;
            			case 4:
            					a[acc_1]-=(txn_array+ctr)->amount;
            					a[acc_2]+=(txn_array+ctr)->amount;
            					a[acc_1]-=((txn_array+ctr)->amount)*0.01;
            					a[acc_2]-=((txn_array+ctr)->amount)*0.01;
            					lock_status[acc_1]=0;
            					lock_status[acc_2]=0;	
            				break;				
            		}

        }
    }

}


int main(int argc, char *argv[]){
	FILE *acc_file,*txn_file;
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
    	txn *pres=txn_array+j;
    	fscanf(txn_file,"%d %d %lf %d %d",&(pres->seq_no),&(pres->type),&(pres->amount),&(pres->ac_1),&(pres->ac_2));
    	//(txn_array+j)->txn_status=0;
    	//printf("%d %d %lf %d %d \n",((txn_array+j)->seq_no),((txn_array+j)->type),((txn_array+j)->amount),((txn_array+j)->ac_1),((txn_array+j)->ac_2));
    }	
 	gettimeofday(&start, NULL);

  pthread_mutex_init(&lock, NULL);

  	/*Partion data and create threads*/      
  	for(int ctr=0; ctr < no_of_threads; ++ctr){
       
        if(pthread_create(&thread[ctr], NULL, do_txn, NULL) != 0){
              perror("pthread_create");
              exit(-1);
        }
    }
    for(int ctr=0; ctr < no_of_threads; ++ctr){
        pthread_join(thread[ctr], NULL);
  	}

    gettimeofday(&end, NULL);
  	for(int ctr=0;ctr<10000;ctr++)
  	{
  		printf("%d %.2lf\n",ctr+1001,a[ctr]);
  	}
  	//printf("Time taken = %ld microsecs\n", TDIFF(start, end));
    return 0;
} 