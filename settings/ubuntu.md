# Ubuntu/Debian

## Grub

Configure GRUB so that when restarting, it enters through the last option selected

``` bash
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved\nGRUB_SAVEDEFAULT=true/g' /etc/default/grub
sudo update-grub
```

## Time

Configuration to avoid problems with the time in Windows / Linux dual boot configurations due to the different treatment they give to UTC.

``` bash
sudo timedatectl set-local-rtc 1
```

## Basic developers tools

Dev tools to work with C/C++ and python

``` bash
apt-get install -y git python3 python3-setuptools python3-pip python3-wheel
apt-get install -y git autotools-dev automake build-essential cmake yasm tmate tig
```

## GStreamer 1.0 tools and dev libraries

From [gstreamer](https://gstreamer.freedesktop.org/documentation/installing/on-linux.html?gi-language=c)

``` bash
apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
```

## Webcam tools

``` bash
apt install uvcdynctrl v4l-utils guvcview

v4l2-ctl --info -L -d /dev/video0 --list-formats-ex
uvcdynctrl -d /dev/video0 -f
```

## Oh My Zsh

Oh My Zsh is a [zsh shell extender](https://ohmyz.sh/)

``` bash
sudo apt install -y zsh
chsh -s $(which zsh)

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)\nZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=6"/g' ~/.zshrc
```

## Install fzf

[fzf](https://github.com/junegunn/fzf) is a general-purpose command-line fuzzy finder

``` bash
cd ~
git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
~/.fzf/install
```

## Chrome

Install Chrome

``` bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
```

## Visual Studio Code

Install Visual Studio Code

``` bash
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code
```

## Docker

Install Docker CE

``` bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
```

## Screen Share

``` bash
sudo apt install gnome-remote-desktop
```

## Install cuda on Ubuntu 20.04

``` bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.5.1/local_installers/cuda-repo-ubuntu2004-11-5-local_11.5.1-495.29.05-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-5-local_11.5.1-495.29.05-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-5-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
```

## Instal cuDNN

First, we need to download the deb package from <https://developer.nvidia.com/rdp/cudnn-download>. The download requires signing up.

``` bash
sudo dpkg -i cudnn-local-repo-${OS}-8.x.x.x_1.0-1_amd64.deb
sudo apt-key add /var/cudnn-local-repo-*/7fa2af80.pub
sudo apt-get update
sudo apt-get install libcudnn8
sudo apt-get install libcudnn8-dev
sudo apt-get install libcudnn8-samples
```
