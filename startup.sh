#!/bin/bash

set -e

source lib/echo.sh

# ################ brew ################

info "brew"

read -r -p "please select profile 1, 2: " profile

if [ "$profile" = 1 ]; then
  BREWFILE="Brewfile"
elif [ "$profile" = 2 ]; then
  BREWFILE="Brewfile-ext"
else
  BREWFILE="Brewfile"
fi

if ! is_executable "brew"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew tap homebrew/bundle
brew bundle --file="./Homebrew/${BREWFILE}" -v
brew cleanup

# ################ ssh ################

info "ssh"

if [ ! -f ~/.ssh/id_rsa.pub ]; then
  read -p "please enter your email address: " email
  ssh-keygen -t rsa -b 4096 -C $email -f ~/.ssh/id_rsa

  eval "$(ssh-agent -s)"

  touch ~/.ssh/config
  echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_rsa" | tee ~/.ssh/config

  ssh-add -K ~/.ssh/id_rsa
else
  echo "ssh skip"
fi

# ################ zsh ################

info "zsh"

if [ -z "$(cat /etc/shells | grep $(brew --prefix)/bin/zsh)" ]; then
  grep -Fxq "$(brew --prefix)/bin/zsh" /etc/shells || sudo sh -c 'echo $(brew --prefix)/bin/zsh >> /etc/shells'
  chsh -s $(brew --prefix)/bin/zsh
else
  echo "zsh skip"
fi

# ################ prezto ################

info "prezto"

if [ ! -d ~/.zprezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  rm -rf ~/.zshrc
  zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ; ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}" ; done'
else
  echo "prezto skip"
fi

# ################ VSCode ################

if is_executable "code"; then
  while read package; do
    code --install-extension $package --force >/dev/null 2>&1
    echo "VScode extension $package installed"
  done <"./vscode/extensions"

  success "VScode successfully configured"
fi
