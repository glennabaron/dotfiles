#!/usr/bin/env bash

# Install binaries using homebrewcask

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
if [[ ! "$(type -P brew)" ]]; then
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Exit if, for some reason, Homebrew is not installed
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && return 1

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Handle dependencies
brew tap caskroom/cask
brew tap caskroom/versions
brew tap buo/cask-upgrade

# dependencies for Formulas and Casks
dependencies=(
  java
  java6
  virtualbox
  vmware-fusion
  xquartz
)

# Install dependencies to /Applications - default is: /Users/$user/Applications
echo "installing dependencies..."

for app in "${dependencies[@]}"
do
  brew cask install --appdir="/Applications" $app
done

# Apps for caskroom
apps=(
  alfred
  alternote
  appcleaner
  blockblock
  dash
  disk-inventory-x
  docker
  docker-toolbox
  dropbox
  firefox
  hazel
  hosts
  imageoptim
  iterm2-beta
  keepingyouawake
  lastpass
  launchrocket
  lockdown
  max
  onyx
  opera
  ostiarius
  paw
  postman
  provisionql
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  quicklook-csv
  sequel-pro
  sketch
  slack
  spectacle
  spotify
  sublime-text
  tower
  transmit
  vagrant
  webpquicklook
)

# Install apps to /Applications - default is: /Users/$user/Applications
echo "installing cask apps..."

for app in "${apps[@]}"
do
  brew cask install --appdir="/Applications" $app --force
done

brew cask cleanup
