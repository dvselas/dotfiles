#!/bin/sh

echo "Setting up your Mac..."

export DOTFILES='/Users/sel0001d/.dotfiles'

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

brew install --build-from-source mono
# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Create a Sites directory
mkdir -p $HOME/Development

# Create sites subdirectories
mkdir -p $HOME/Development/private
mkdir -p $HOME/Development/glomex

# Clone Github repositories
$DOTFILES/clone.sh

# Symlink the Mackup config file to the home directory
ln -s $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

sudo ln -s /usr/bin/python3 /usr/bin/python
dockutil --no-restart --add '/Applications/Safari.app'
dockutil --no-restart --add '/Applications/Fantastical.app'

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos
