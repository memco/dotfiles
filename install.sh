#!/bin/sh

echo "Setting up Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Can't do bundle install without mas being seutp first
if test ! $(which mas); then
	brew install mas
fi
mas signin $(mas account)

# Move Brewfile into place
ln -fs ~/.dotfiles/Brewfile ~/

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install fish config
ln -fs ~/.dotfiles/.config ~/

# Install oh-my-fish
curl -L https://get.oh-my.fish | fish

# Install my-sushi
ln -fs ~/.dotfiles/omf-mysushi ~/.local/share/omf/themes/

# Use Sushi theme
omf theme omf-mysushi | fish

# Make fish the default shell environment
chsh -s $(which fish)

# ZSH Config (Just in case)
ln -fs ~/.dotfiles/.zshrc ~/

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/lumen-installer laravel/valet tightenco/jigsaw spatie/http-status-check bramus/mixed-content-scan laravel/spark-installer

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Install global NPM packages
npm install --global yarn
npm install -g reveal-md 

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Start Web Services
# brew services start postgresql
# brew services start mariadb
sudo brew services start dnsmasq

# Vim Setup
# Install .vimrc
ln -fs  ~/.dotfiles/.vimrc ~/
ln -fs  ~/.dotfiles/.vim ~/

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set macOS preferences
# We will run this last because this will reload the shell
source default-preferences