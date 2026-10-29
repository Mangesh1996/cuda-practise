# cuda-practise
cd ~/Downloads

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb

sudo dpkg -i cuda-keyring_1.1-1_all.deb

sudo apt update
sudo apt install cuda-toolkit

Configure your environment

After installation, check the location of CUDA:

ls -l /usr/local/ | grep cuda

If your installed toolkit is under /usr/local/cuda, add its binaries to your PATH:

echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc

Load the updated shell configuration:

source ~/.bashrc

Check:

which nvcc
nvcc --version

Compile the CUDA program

For your GTX 1650, explicitly target compute capability 7.5:

nvcc -std=c++17 -arch=sm_75 vector_add.cu -o vector_add