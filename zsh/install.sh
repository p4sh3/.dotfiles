#!/bin/bash


echo -e "\033[30;46mInstalling zsh...\033[0m"

# plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

sudo nala install zsh
echo ""

# mkdir -p ${ZDOTDIR:-$HOME}/.zshrc
echo ""
