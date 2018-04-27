#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

__global__ void calculate(int *mem, int num, int offs)
{
      int i = blockDim.x * blockIdx.x + threadIdx.x;
      if(i-1 >= (num/(2*offs)))
           return;
      if((2*offs*i + offs) >= num)
        return;
      mem[2*offs*i] = mem[2*offs*i]^mem[2*offs*i + offs];

}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    int i,num;
    int *ptr;
    int *gpu_mem;
    int blocks;
    unsigned int seed;
    if(argc == 3){
         num = atoi(argv[1]);
         seed = atoi(argv[2]);
    }
    srand(seed);

    ptr = (int *)malloc(num*sizeof(int));
    for(i=0; i<num; ++i){
       ptr[i] = random();
    }

    gettimeofday(&t_start, NULL);

    cudaMalloc(&gpu_mem, num * sizeof(int));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, ptr, num * sizeof(int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");

    gettimeofday(&start, NULL);

    blocks = num /1024;

    if(num % 1024)
           ++blocks;

    for(int x=1;x<num;x*=2)
    {
        calculate<<<blocks, 1024>>>(gpu_mem, num, x);
    }

    CUDA_ERROR_EXIT("kernel invocation");
    gettimeofday(&end, NULL);

    cudaMemcpy(ptr, gpu_mem, num * sizeof(int) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);

    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);

    printf("result=%d\n",ptr[0]);

    free(ptr);
}
