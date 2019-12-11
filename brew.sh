#!/usr/bin/env bash

# install command-line tools using homebrew

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
brew upgrade

# taps
brew tap homebrew/homebrew-php

# install gnu core utilities (those that come with os x are outdated)
# don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$path`
brew install coreutils

# install some other useful utilities like `sponge`
brew install moreutils

# install gnu `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils

# install gnu `sed`, overwriting the built-in `sed`
brew install gnu-sed

# install bash 4
# note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`
brew install bash
brew install bash-completion2

# switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# install `wget`
brew install wget

# install more recent versions of some OS X tools
brew install vim
brew install grep
brew install openssh
brew install screen

# install font tools
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# tap services - https://github.com/Homebrew/homebrew-services
brew tap homebrew/services

# install current version of php
# brew install php71
# brew install php71-mcrypt
# brew install php71-xdebug

# install php mods / composer
brew install composer
brew install phpmd
brew install php-code-sniffer
brew install php-cs-fixer

# install some http benchmarking tools
brew install wrk
brew install siege
brew install vegeta

# install some network benchmarking/testing tools
brew install iperf3
brew install nuttcp
brew install mtr
brew install owamp
brew install scamper
brew install whatmask
brew install testssl

# ssh stuff
brew install ssh-copy-id
brew install stormssh

# install some more CTF tools - see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dnsmasq
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install reaver
brew install snort
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install tcpdump
brew install trafshow
brew install dhcpdump
brew install ucspi-tcp # `tcpserver` etc.
brew install xz

# install other useful binaries
brew install ack
brew install autojump
brew install dark-mode
brew install diff-so-fancy
brew install exiv2
brew install git
brew install git-lfs
brew install hub
brew install htop
brew install imagemagick
brew install lua
brew install lynx
brew install ngrep
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rhino
brew install speedtest_cli
brew install the_silver_searcher
brew install tree
brew install trash
brew install unzip
brew install webkit2png
brew install zopfli
brew install z

# install node version manager
brew install nvm

# install rbenv and ruby build
brew install rbenv
brew install ruby-build
brew install rbenv-default-gems

# use brewed git
brew link git --overwrite

# config git
curl -s -O \
https://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain

chmod u+x git-credential-osxkeychain

sudo mv git-credential-osxkeychain "$(dirname $(which git))/git-credential-osxkeychain"

git config --global credential.helper osxkeychain

# private repo access
pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
if
  [ ! -f $pub ] ; then
  ssh-keygen -t rsa
  echo 'Copying public key to clipboard. Paste it into your Github account...'
  cat $pub | pbcopy
  open 'https://github.com/account/ssh'
fi

# go
brew install go

# sharp
brew install vips --with-webp --with-graphicsmagick

# yarn
brew install yarn

# remove outdated versions from the cellar
brew cleanup
