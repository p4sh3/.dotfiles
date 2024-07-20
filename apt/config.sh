#!/bin/bash

# Install apt front-end
sudo apt update > /dev/null 2>&1 && sudo apt install nala > /dev/null 2>&1

#Update mirrors
# sudo nala fetch

# Convert APT to Nala
# echo "Convert APT to Nala ~/.zshrc:"
# {
#   echo ''
#   echo '# nala'
#   echo 'apt() {'
#   echo '  command nala "$@"'
#   echo '}'
#   echo 'sudo() {'
#   echo '  if [ "$1" = "apt" ]; then'
#   echo '    shift'
#   echo '    command sudo nala "$@"'
#   echo '  else'
#   echo '    command sudo "$@"'
#   echo '  fi'
#   echo '}'
#   echo ''
# } >> "~/.zshrc"

echo ""