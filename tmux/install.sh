#!/bin/bash

sudo nala install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


CONF_FILE=$HOME/.zshrc
echo -e "\033[30;46mInstalling tmux.\033[0m"
echo -e "\nAppending the following to $CONF_FILE:"
{
  echo ''
  echo '# automatically start tmux as default'
  echo 'if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then'
  echo '  tmux attach -t default || tmux new -s default'
  echo 'fi'
  echo ''
} | tee -a "$HOME/.dotfiles/zsh/.zshrc"

echo -e "\n"

