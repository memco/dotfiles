#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Move Brewfile into place
cp ~/.dotfiles/Brewfile ~/

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make fish the default shell environment
chsh -s $(which fish)

# Install fish config
cp ~/.dotfiles/config.fish ~/.config/fish/

# Install oh-my-fish
curl -L https://get.oh-my.fish | fish

# Install my-sushi
cp ~/.dotfiles/omf-mysushi ~/.local/share/omf/themes/

# Use Sushi theme
omf theme omf-mysushi | fish

# ZSH Config (Just in case)
cp ~/.dotfiles/.zshrc ~/

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
brew services start postgresql
brew services start mariadb
sudo brew services start dnsmasq

# Set macOS preferences
# We will run this last because this will reload the shell
source default-preferences