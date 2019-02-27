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
  fonts-powerline
  dconf-cli
  gnome-themes-standard
  gtk2-engines-murrine
  libgtk-3-dev
)

sudo apt install "${apps[@]}"

#ccat
wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz -O /tmp/ccat-linux-amd64-1.1.0.tar.gz
sudo tar -xzvf /tmp/ccat-linux-amd64-1.1.0.tar.gz -C /usr/local/bin

#oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# zsh-autosugesstions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#0i0 theme
rm -rf ~/.oh-my-zsh/themes
git clone https://github.com/0i0/0i0.zsh-theme.git ~/.oh-my-zsh/themes

cd $HOME/src

git clone https://github.com/0i0/arc-theme.git
git clone https://github.com/0i0/arc-icon-theme.git
git clone https://github.com/tryone144/compton.git

# arc icons modified
cd $HOME/src/arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install

# arc Dark modified
cd $HOME/src/arc-theme
./autogen.sh --prefix=/usr
sudo make install

# compton with blur
cd $HOME/src/compton
sudo apt install libconfig-dev
sudo apt install asciidoc
make
make docs
make install



echo "Seting up dotfile dir"

cd "$(dirname "${BASH_SOURCE}")"

git init
git remote add origin git@github.com:0i0/dotfiles.git
git fetch --all
git reset --hard origin/master
git pull origin master

echo "Linking.."

# Symlink dotfiles
rm -rf $HOME/.config
for file in $(ls -A); do
if [ "$file" != ".git" ] && \
  [ "$file" != "setup.sh" ] && \
  [ "$file" != "remote-setup.sh" ] && \
  [ "$file" != "README.md" ]; then
  ln -sf $PWD/$file $HOME/
fi
done

# Zsh shall be default
if [[ $- == *i* ]]; then
    export SHELL=zsh
    zsh -l
fi

# Gnome terminal theme
echo "run: bash -c  \"\$(wget -qO- https://git.io/vQgMr)\""