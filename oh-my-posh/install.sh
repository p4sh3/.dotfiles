#!/bin/bash

echo -e "\033[30;46mInstalling Oh My Posh\033[0m"
if ! curl  --progress-bar --fail -L -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin; then
    echo "\033[37;41mDownload failed.\033[0m"
    exit 1
fi


oh-my-posh font install firacode



echo -e "\033[30;46mInstalling Oh My Posh theme: stars\033[0m"
mkdir ~/.poshthemes
if ! curl --progress-bar --fail -L https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/star.omp.json -o ~/.poshthemes/star.omp.json; then
    echo "\033[37;41mDownload failed.\033[0m"
    exit 1
fi

echo ""

