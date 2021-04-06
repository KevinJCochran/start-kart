#!/usr/bin/env bash

# Setup keys
sudo apt-get -y install dirmngr
sudo apt-key adv \
--keyserver hkp://keyserver.ubuntu.com:80 \
--recv-keys BC359FFF5A04B56C41DBC134289CABAB043F53A7

# install packages
sudo add-apt-repository -y ppa:kartkrew/srb2kart
sudo apt-get -y update
sudo apt-get -y install srb2kart

# Install mods
# TODO

# Start server
srb2kart -dedicated
