#!/usr/bin/env bash

# install binaries using homebrewcask

# ask for the administrator password upfront
sudo -v

# keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# install homebrew
if [[ ! "$(type -P brew)" ]]; then
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# exit if, for some reason, homebrew is not installed
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && return 1

# make sure we’re using the latest homebrew
brew update

# upgrade any already-installed formulae
brew upgrade --all

# handle dependencies
brew tap caskroom/cask
brew tap caskroom/versions
brew tap buo/cask-upgrade

# dependencies for formulas and casks
dependencies=(
  java
  java6
  virtualbox
  vmware-fusion
  xquartz
)

# install dependencies to /Applications - default is /Users/$user/Applications
echo "installing dependencies..."

for app in "${dependencies[@]}"
do
  brew cask install --appdir="/Applications" $app
done

# apps for caskroom
apps=(
  alfred
  appcleaner
  blockblock
  dash
  disk-inventory-x
  docker
  docker-toolbox
  dropbox
  firefox
  github
  hazel
  hosts
  imageoptim
  insomnia
  iterm2
  itsycal
  kap
  keepingyouawake
  lastpass
  launchrocket
  lockdown
  max
  onyx
  opera
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
  rocket
  sequel-pro
  sketch
  slack
  spectacle
  spotify
  sublime-text
  sublime-merge
  tower
  transmit
  vagrant
  webpquicklook
  zoom
)

# install apps to /Applications - default is /Users/$user/Applications
echo "installing cask apps..."

for app in "${apps[@]}"
do
  brew cask install --appdir="/Applications" $app --force
done

brew cask cleanup
