#!/bin/bash


# Pre-authorise sudo
sudo echo

#Config apt
bash ./apt/config.sh

# Installing dependencies
echo -e "\033[30;46mInstalling dependencies...\033[0m"
sudo nala install curl unzip cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 rustup
echo ""



# Installing Oh My Posh
bash ./oh-my-posh/install.sh

# Installing zsh
bash ./zsh/install.sh

# Installing alacritty
bash ./alacritty/install.sh


# Installing fnm
bash ./fnm/install.sh

# Installing tmux
bash ./tmux/install.sh

# Installing grub theme
echo -e "\033[30;46mInstalling grub theme\033[0m"
wget -O- https://github.com/p4sh3/fallout-grub-theme/raw/master/install.sh | bash -s -- --lang English


ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

# mkdir ~/.config/alacritty
ln -sf ~/.dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml


{
  echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
  echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
} >> "$HOME/.dotfiles/zsh/.zshrc"


# zsh as default shell
echo -e "\033[30;46mSetting zsh as default shell\033[0m"
chsh -s $(which zsh)

