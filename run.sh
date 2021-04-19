#!/bin/bash

# Get up to speed
sudo apt update
sudo apt full-upgrade -y


# Make container for downloads
sudo mkdir /tmp/setup/
tmpdir='/tmp/setup'


# Get some essentials
sudo apt install apt-transport-https chromium curl git gcc g++ make perl r-recommended vim zsh -y


# Get sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt update
sudo apt install sublime-text -y


# Get miniconda
sudo wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $tmpdir/miniconda.sh
sh $tmpdir/miniconda.sh -b -p $HOME/miniconda

eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init bash
conda init zsh

# install preferred packages to base
conda install numpy scipy matplotlib ipython jupyter pandas sympy nose seaborn requests beautifulsoup4 -y


# Get zsh and Oh-My-ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Get fonts for powerlevel10k and then git powerlevel10k
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

sudo curl https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Regular.ttf -o $tmpdir'MesloLGS NF Regular.ttf' 
sudo curl https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold.ttf -o $tmpdir'MesloLGS NF Bold.ttf' 
sudo curl https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Italic.ttf -o $tmpdir'MesloLGS NF Italic.ttf' 
sudo curl https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold%20Italic.ttf -o $tmpdir'MesloLGS NF Bold Italic.ttf' 

sudo cp -f $tmpdir/*.ttf /usr/share/fonts/truetype/

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set ZSH theme to powerlevel10k and set plugins


# Cleanup
sudo apt auto-remove -y


# Reboot into a ready environment
echo "System will reboot in 60 secs."
sleep 1m
sudo reboot