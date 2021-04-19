#!/bin/bash

# TODO: Find way to record runner of script or check for this argument
LOCAL_USER=$1
LOCAL_HOME=/Home/$1


[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

echo $LOCAL_HOME
echo $LOCAL_USER

# Variable Declarations
TMPDIR='/tmp/setup'
FONTDIR='/usr/share/fonts/truetype/'


# Make container for downloads
mkdir /tmp/setup/


# Add sublime-text keys to apt
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list


# Get up to speed
apt update
apt full-upgrade


# Get some essentials
apt install -y apt-transport-https chromium-browser curl git gcc g++ make perl r-recommended sublime-text vim zsh


# Get miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $TMPDIR/miniconda.sh
sh $TMPDIR/miniconda.sh -b -p $LOCAL_HOME/miniconda

eval "$($LOCAL_HOME/miniconda/bin/conda shell.bash hook)"
conda init bash
conda init zsh

# install preferred packages to base
conda install -y numpy scipy matplotlib ipython jupyter pandas sympy nose seaborn requests beautifulsoup4


# Get Oh-My-ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Get fonts for powerlevel10k and then git powerlevel10k
curl https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Regular.ttf -o $FONTDIR'MesloLGS NF Regular.ttf' 
curl https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold.ttf -o $FONTDIR'MesloLGS NF Bold.ttf' 
curl https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Italic.ttf -o $FONTDIR'MesloLGS NF Italic.ttf' 
curl https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold%20Italic.ttf -o $FONTDIR'MesloLGS NF Bold Italic.ttf'

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$LOCAL_HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set ZSH theme to powerlevel10k and set plugins
# TODO: Set theme and set plugins and set default font in terminal

# Cleanup
apt auto-remove -y


# Reboot into a ready environment
echo "System will reboot in 60 secs."
sleep 10
reboot