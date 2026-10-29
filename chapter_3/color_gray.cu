#include <iostream>
#include <cuda_runtime.h>
#include <vector>

__global__ void rgbTograyKernal(const unsigned char* d_rgb,unsigned char* d_gray,
                                int width,int height){
            int x=blockIdx.x*blockDim.x+threadIdx.x;
            int y=blockIdx.y*blockDim.y+threadIdx.y;
            if(x<width && y<height){
                int grayoffset = y*width+x;
                int rgbOffset=grayoffset*3;
                unsigned char r=d_rgb[rgbOffset];
                unsigned char g=d_rgb[rgbOffset+1];
                unsigned char b=d_rgb[rgbOffset+2];
                
            d_gray[grayoffset]=(unsigned char)(0.299f*r+0.587f*g+0.114f*b);
        }
        }
int main(){

        const int width=2;
        const int height=2;
        const int total_pixels=width* height;
        const int rgb_bytes=total_pixels*3;
        const int gray_bytes=total_pixels*1;
        std::vector<unsigned char> h_rgb={
            255,0,0,
            0,255,0,
            0,0,255,
            255,255,255
        };
        std::vector<unsigned char> h_gray(total_pixels);
        unsigned char *d_rgb=nullptr;
        unsigned char *d_gray=nullptr;
        cudaMalloc(&d_rgb,rgb_bytes);
        cudaMalloc(&d_gray,gray_bytes);
        cudaMemcpy(d_rgb,h_rgb.data(),rgb_bytes,cudaMemcpyHostToDevice);
        dim3 blocksize(16,16);
        dim3 gridsize((width+blocksize.x-1)/blocksize.x,
                        (height+blocksize.y-1)/blocksize.y);
        rgbTograyKernal<<<gridsize,blocksize>>>(d_rgb,d_gray,width,height);
        cudaDeviceSynchronize();
        cudaMemcpy(h_gray.data(),d_gray,gray_bytes,cudaMemcpyDeviceToHost);
        std::cout << "Grayscale output values: \n";
        for(int y=0;y<height;++y){
            for(int x=0;x<width;++x){
                int idx=y*width+x;
                std::cout <<(int)h_gray[idx]<< " ";
            }
            std::cout <<"\n";
        }

        cudaFree(d_gray);
        cudaFree(d_rgb);
        return 0;
    }