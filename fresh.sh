#!/bin/sh

echo "Setting up your Mac..."

export DOTFILES='/Users/sel0001d/.dotfiles'

# Check for Oh My Zsh and install if we don't have it
if [ ! -d "$HOME/.oh-my-zsh" ] ; then
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
ln -sf $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

curl -sSL https://get.rvm.io | bash -s stable
curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
rvm-installer.asc && bash rvm-installer stable
[[ -s '$HOME/.rvm/scripts/rvm' ]] && source '$HOME/.rvm/scripts/rvm'
rvm install 3.1.2
rvm use 3.1.2

# Set macOS preferences - we will run this last because this will reload the shell
#source $DOTFILES/.macos

# Dock icons
#$HOME/Development/private/dock.sh/dock.sh