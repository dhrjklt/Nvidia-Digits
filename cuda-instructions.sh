# Download the cuda deb package
# Link: https://developer.nvidia.com/cuda-downloads
wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-ubuntu1404-8-0-local_8.0.44-1_amd64-deb
wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb

# Verify you have a GPU on the system and it is being detected properly
lspci | grep -i nvidia

# Verify that you are running the supported OS
uname -m && cat /etc/*release

# Verify the gcc version
which gcc && gcc --version

# Verify that the system has linux kernel headers installed
sudo apt-get install linux-headers-$(uname -r)

# Update ld-conf for the runtime to automatically find your libraries
echo "/usr/local/cuda/lib64" | sudo tee /etc/ld.so.conf.d/cuda64.conf
sudo ldconfig

# Blacklist nouveau driver
echo "blacklist nouveau
options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf
sudo update-initramfs -u

# Reboot into text mode, before running the .run file
sed -e 's/quiet splash/text/' < /etc/default/grub > tt
sudo mv tt /etc/default/grub
sudo update-initramfs -u -v
sudo update-grub
sudo reboot

# install cuda sdk and driver
# The file name changes as per the sdk version and your OS!
sudo dpkg -i cuda-repo-ubuntu1404-8-0-local_8.0.44-1_amd64.deb
sudo apt-get update
sudo apt-get install cuda

# Reboot into graphical mode
sed -e 's/text/quiet splash/' < /etc/default/grub > tt
sudo mv tt /etc/default/grub
sudo update-initramfs -u -v
sudo update-grub
sudo reboot

# Verify the installation
nvidia-smi

# Perform env-setup
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=/usr/local/cuda-8.0/bin$PATH' >> ~/.bashrc
source ~/.bashrc

# install digits
ML_REPO_PKG=nvidia-machine-learning-repo-ubuntu1404_4.0-2_amd64.deb
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64/$ML_REPO_PKG -O /tmp/$ML_REPO_PKG
sudo dpkg -i /tmp/$ML_REPO_PKG
sudo apt-get update
sudo apt-get install digits

# TIP-1: to stop and start digits server
sudo stop nvidia-digits-server
sudo start nvidia-digits-server

# TIP-2: to configure digits setup
cd /usr/share/digits && sudo python -m digits.config.edit -v

