#!/bin/bash

echo -e "\033[30;46mInstalling fnm\033[0m"
set -e

if [ -d "$HOME/.fnm" ]; then
  INSTALL_DIR="$HOME/.fnm"
elif [ -n "$XDG_DATA_HOME" ]; then
  INSTALL_DIR="$XDG_DATA_HOME/fnm"
else
  INSTALL_DIR="$HOME/.local/share/fnm"
fi



set_filename() {
  # Based on https://stackoverflow.com/a/45125525
  case "$(uname -m)" in
    arm | armv7*)
      FILENAME="fnm-arm32"
      ;;
    aarch* | armv8*)
      FILENAME="fnm-arm64"
      ;;
    *)
      FILENAME="fnm-linux"
  esac
}

download_fnm() {
  URL="https://github.com/Schniz/fnm/releases/latest/download/$FILENAME.zip"

  DOWNLOAD_DIR=$(mktemp -d)

  echo "Downloading $URL..."

  mkdir -p "$INSTALL_DIR" &>/dev/null

  if ! curl --progress-bar --fail -L "$URL" -o "$DOWNLOAD_DIR/$FILENAME.zip"; then
    echo -e "\033[37;41mDownload failed.  Check that the release/filename are correct.\033[0m"
    exit 1
  fi

  unzip -q "$DOWNLOAD_DIR/$FILENAME.zip" -d "$DOWNLOAD_DIR"

  if [ -f "$DOWNLOAD_DIR/fnm" ]; then
    mv "$DOWNLOAD_DIR/fnm" "$INSTALL_DIR/fnm"
  else
    mv "$DOWNLOAD_DIR/$FILENAME/fnm" "$INSTALL_DIR/fnm"
  fi

  chmod u+x "$INSTALL_DIR/fnm"
}

setup_shell() {
  CONF_FILE=${ZDOTDIR:-$HOME}/.zshrc

  echo "Installing for Zsh. Appending the following to $CONF_FILE:"
  {
    echo ''
    echo '# fnm'
    echo 'FNM_PATH="'"$INSTALL_DIR"'"'
    echo 'if [ -d "$FNM_PATH" ]; then'
    echo '  export PATH="'$INSTALL_DIR':$PATH"'
    echo '  eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"'
    echo 'fi'
    echo ''
  } | tee -a "$HOME/.dotfiles/zsh/.zshrc"
}

set_filename
download_fnm
setup_shell

echo ""