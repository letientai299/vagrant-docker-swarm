#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

function task() {
  echo
  echo
  echo "========================================"
  echo "$*"
  echo "========================================"
}

task "Build essential"
sudo apt-get install -y build-essential


task "Docker"
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 \ --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-zesty main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
# sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual -y
sudo apt-get install docker-engine --force-yes -y
sudo usermod -aG docker vagrant
sudo service docker start
docker version

task "Neovim"
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install neovim -y

task "Python and neovim binding"
sudo apt-get install python python-dev -y
pip install --upgrade pip
pip install --user neovim

task "httpie"
pip install --user --upgrade httpie

task "pgcli"
sudo apt install pgcli -y

task "Tmux"
sudo apt-get install tmux -y
pip3 install --user powerline-status

task "ag search"
sudo apt-get install silversearcher-ag -y

task "curl and wget"
sudo apt-get install -y curl wget

task "zsh"
sudo apt-get install -y zsh
sudo chsh  -s "$(which zsh)"
sudo chsh  -s "$(which zsh)" $USER

task "Xterm 256 italic"
cd $HOME
mkdir temp
cd temp
wget "https://gist.github.com/sos4nt/3187620/raw/bca247b4f86da6be4f60a69b9b380a11de804d1e/xterm-256color-italic.terminfo"
tic xterm-256color-italic.terminfo

