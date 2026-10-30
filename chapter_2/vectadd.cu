#include <iostream>
#include <cuda_runtime.h>
#include <vector>
#include <cmath>
#define CUDA_CHECK(call){
    do{
        cudaError_t error=(call);
        if(err != cudaSuccess){
            std::cerr <<"CUDA ERROR: "<< cudaGetErrorString(err)<< " at "<< __FILE__ << std::endl;
            std::exit(EXIT_FAILURE);
        }
    }while(0)
}
__global__ void vect_add(float* A,float* b,float* c,size_t n){
    size_t idx=blockDim.x*blockIdx.x+threadIdx.x;
    if(n >idx){
        c[idx]=A[idx]+b[idx];
    }
}


int main(){
    constexpr size_t n=1024;
    std::vector<float> A_h(n);
    std::vector<float> B_h(n);
    std::vector<float> C_h(n);

    for(int i=0; i< n;i++){
        A_h[i]=i;
        B_h[i]=i*2;
    }

    constexpr size_t size=n*sizeof(float);
    float* A_d=nullptr;float* B_d=nullptr;float* C_d=nullptr;
    cudaMalloc(&A_d,size);
    cudaMalloc(&B_d,size);
    cudaMalloc(&C_d,size);
    cudaMemcpy(A_d,A_h.data(),size,cudaMemcpyHostToDevice);
    cudaMemcpy(B_d,B_h.data(),size,cudaMemcpyHostToDevice);
    dim3 blocks(256);
    dim3 grid((n +blocks.x-1)/blocks.x);
    vect_add<<<grid,blocks>>>(A_d,B_d,C_d,n);
    cudaMemcpy(C_h.data(),C_d,size,cudaMemcpyDeviceToHost);
    cudaFree(A_d);
    cudaFree(B_d);
    cudaFree(C_d);
    for(int i=0;i<n;i++){
        std::cout << C_h[i] << std::endl;
    }
    
}