#!/bin/bash

set -e

source lib/echo.sh

SCRIPT_DIR=$(cd $(dirname $0) && pwd)

info "fzf"

$(brew --prefix)/opt/fzf/install

info "VSCode"
rm -rf ~/Library/Application\ Support/Code/User/settings.json
ln -s ${SCRIPT_DIR}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

info "vim"
rm -rf ~/.vimrc
ln -s ${SCRIPT_DIR}/vim/.vimrc ~/.vimrc

info "zsh"
rm -rf ~/.zshrc ~/.zpreztorc
ln -s ${SCRIPT_DIR}/zsh/.zshrc ~/.zshrc
ln -s ${SCRIPT_DIR}/zsh/.zpreztorc ~/.zpreztorc
