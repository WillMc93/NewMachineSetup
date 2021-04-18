#!/bin/bash

# Get up to speed
sudo apt update
sudo apt full-upgrade -y
sudo apt install gcc g++ make perl curl

# Make container for downloads
sudo mkdir /tmp/setup/
tmpdir='/tmp/setup'

# Get zsh and Oh-My-ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Get fonts for powerlevel10k and then git powerlevel10k
curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o $tmpdir/MesloReg.ttf
curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o $tmpdir/MesloBold.ttf
curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o $tmpdir/MesloItalic.ttf
curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o $tmpdir/MesloIB.ttf

cd $tmpdir
sudo cp *.ttf /usr/share/fonts/truetype/


git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k