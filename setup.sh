#!/bin/bash

# Make sure we’re using the latest repositories
sudo apt update

apps=( 
	git
	screen
	tmux
	wget
	zsh

    scrot
    feh

    dconf-cli
)

sudo apt install "${apps[@]}"

#ccat
wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz -O /tmp/ccat-linux-amd64-1.1.0.tar.gz
sudo tar -xzvf /tmp/ccat-linux-amd64-1.1.0.tar.gz -C /usr/local/bin

#oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#0i0 theme
rm -rf ~/.oh-my-zsh/themes
git clone https://github.com/0i0/0i0.zsh-theme.git ~/.oh-my-zsh/themes


echo "Seting yp dotfile dir"

cd "$(dirname "${BASH_SOURCE}")"

git init

git remote add origin https://github.com/0i0/dotfiles.git

git fetch --all
git reset --hard origin/master

git pull origin master

echo "Linking.."

# Symlink dotfiles
for file in $(ls -A); do
if [ "$file" != ".git" ] && \
   [ "$file" != "setup.sh" ] && \
   [ "$file" != "remote-setup.sh" ] && \
   [ "$file" != "README.md" ]; then
    ln -sf $PWD/$file $HOME/
fi
done 

# Gnome terminal theme
bash -c  "$(wget -qO- https://git.io/vQgMr)"