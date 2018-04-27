#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<sys/time.h>
#define NUM 10000000

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

__global__ void calculate(char *mem, int num,int skip)
{      
      int *arr=(int *)mem;   
      int i = blockDim.x * blockIdx.x + threadIdx.x;
      if((i*2*skip) >= num-1)
           return;
      *(arr+i*2*skip)=(*(arr+i*2*skip))^(*(arr+i*2*skip+skip));
      return;     
       
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    int i,seed;
    char *ptr;
    char *sptr;
    int *pa;
    char *gpu_mem;   
    unsigned long num = NUM;   /*Default value of num from MACRO*/
    int blocks;

    if(argc == 3){
         num = atoi(argv[1]);   /*Update after checking*/
         if(num <= 0)
               num = NUM;
         seed=atoi(argv[2]);                  
    }

    srand(seed);

    /* Allocate host (CPU) memory and initialize*/

    ptr = (char *)malloc(num * sizeof(int));
    sptr = ptr; 
    for(i=0; i<num; ++i){
       pa = (int*) sptr;
       *pa=(int)rand();
       sptr +=sizeof(int);
    }
    
    
    gettimeofday(&t_start, NULL);
    
    /* Allocate GPU memory and copy from CPU --> GPU*/

    cudaMalloc(&gpu_mem, num * sizeof(int));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, ptr, num * sizeof(int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");
    
    gettimeofday(&start, NULL);
    
    blocks = num /1024;
    
    if(num % 1024)
           ++blocks;

    int skip=1;       
    for(i=num;i>1;){       
    calculate<<<blocks, 1024>>>(gpu_mem, num,skip);
    CUDA_ERROR_EXIT("kernel invocation");
    skip=skip*2;
    if(i%2==0)
        i=i/2;
    else i=i/2+1;    
    }
    gettimeofday(&end, NULL);
    
    /* Copy back result*/

    cudaMemcpy(ptr, gpu_mem, num * sizeof(int) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);
    
    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);
    sptr = ptr;
   
    /*Print the answer*/ 
    pa = (int*)sptr;
    printf("result=%d\n", *pa);

    
    free(ptr);
}
