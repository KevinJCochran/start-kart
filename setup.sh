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

# Create kartserv.cfg
# kartserv.cfg is read on startup

# This directory would be automatically created on first run of srb2kart
# But we need to put stuff in it before first boot
mkdir /root/.srb2kart/
# It must be located in /root/.srb2kart/kartserv.cfg (assuming running as root)
echo "addfile hornmod.pk3" > /root/.srb2kart/kartserv.cfg

# Download hornmod.pk3
# This might fail if the hosting server is ever down or if the path changes
curl https://mb.srb2.org/attachments/kl_hornmod_v5-io2-pk3.22515/ > /usr/games/SRB2Kart/hornmod.pk3

# TODO install custom horns
# TODO update config file with custom horns

# Start server
srb2kart -dedicated
