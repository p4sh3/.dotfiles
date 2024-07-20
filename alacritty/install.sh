#!/bin/bash

DIR=$HOME/.repositories

echo -e "\033[30;46mInstalling Alcritty\033[0m"
mkdir "$DIR"
cd "$DIR"
git clone https://github.com/alacritty/alacritty.git
cd alacritty


# echo -e "\033[30;46mInstalling rust\033[0m"
# sudo nala install rustup


rustup override set stable
rustup update stable

# Force support for only Wayland
cargo build --release --no-default-features --features=wayland

# Terminfo
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# Desktop Entry
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Theme
echo -e "\033[30;46mInstalling catppuccin theme with mocha flavor\033[0m"
mkdir ~/.config/alacritty

if ! curl --progress-bar -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml; then
    echo -e "\033[37;41mDownload failed.\033[0m"
    exit 1
fi

echo ""