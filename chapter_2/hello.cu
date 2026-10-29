#include <iostream>
#include <cuda_runtime.h>
#include <cstdio>

__global__ void hello_world(){
    printf("Hello from GPU ! Thread ID: %d\n",threadIdx.x);
}
int main(){
    hello_world<<<1,4>>>();
    cudaDeviceSynchronize();
    return 0;
}