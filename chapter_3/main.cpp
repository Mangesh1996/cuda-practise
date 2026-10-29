#include <iostream>
#include <vector>
#include <opencv2/opencv.hpp>
#include <cuda_runtime.h>


int main(){

    cv::Mat image=cv::imread("/home/magnesh/Documents/workspace/c++_workspace/cuda_leaning/sample-images-main/image-1.jpg");
    if(image.empty()){
        std::cerr << "Image faile to read"<< std::endl;
        return -1;
    }
    std::cout << "Image load sucessfully "<< std::endl;
    std::cout << image.cols << std::endl;
    std::cout << image.rows << std::endl;
    const int image_size=image.cols *image.rows;
    const int image_bytes=image_size*3;

    std::cout << image_size << std::endl;
    std::cout << image_bytes << std::endl;

}