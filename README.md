# Nvidia-Digits
Nvidia Deep Learning GPU Training System (DIGITS) installation script. 

To know more about Nvidia-DIGITS
https://github.com/NVIDIA/DIGITS/blob/master/docs/GettingStarted.md

# Download the packages 
Considering for Ubuntu 14.0 

wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-ubuntu1404-8-0-local_8.0.44-1_amd64-deb

wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb

# Follow the procedure 

Verify you have a GPU on the system and it is being detected properly

lspci | grep -i nvidia

Verify that you are running the supported OS

uname -m && cat /etc/*release

Verify that the system has linux kernel headers installed

sudo apt-get install linux-headers-$(uname -r)

Update ld-conf for the runtime to automatically find your libraries

echo "/usr/local/cuda/lib64" | sudo tee /etc/ld.so.conf.d/cuda64.conf

sudo ldconfig
