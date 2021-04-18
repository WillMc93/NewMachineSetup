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
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $tmpdir/miniconda.sh
sh $tmpdir/miniconda.sh -b -p $HOME/miniconda

eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init

echo "# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/will/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/will/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/will/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/will/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<" >> ~/.zshrc




# Get zsh and Oh-My-ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Get fonts for powerlevel10k and then git powerlevel10k
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o $tmpdir/MesloReg.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o $tmpdir/MesloBold.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o $tmpdir/MesloItalic.ttf
sudo curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o $tmpdir/MesloIB.ttf

sudo cp -f $tmpdir/*.ttf /usr/share/fonts/truetype/

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
