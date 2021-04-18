#!/bin/bash

# Get up to speed
sudo apt update
sudo apt full-upgrade -y


# Get some essentials
sudo apt install curl gcc g++ make perl r-recommended vim zsh -y


# Make container for downloads
sudo mkdir /tmp/setup/
tmpdir='/tmp/setup'


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
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o $tmpdir/MesloReg.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o $tmpdir/MesloBold.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o $tmpdir/MesloItalic.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o $tmpdir/MesloIB.ttf

sudo cp -f $tmpdir/*.ttf /usr/share/fonts/truetype/

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set ZSH theme to powerlevel10k and set plugins for powerlevel10k


# Cleanup
sudo apt auto-remove -y

# Reboot to re-source all files
echo "System will reboot in 60 secs."
sleep 1m
sudo reboot