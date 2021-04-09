#!/usr/bin/env bash

# Check if srb2kart is installed
if command -v srb2kart &> /dev/null
then
    echo "srb2kart found, skipping installation"
else
    # Install srb2kart
    # Setup keys
    sudo apt-get -y install dirmngr
    sudo apt-key adv \
        --keyserver hkp://keyserver.ubuntu.com:80 \
        --recv-keys BC359FFF5A04B56C41DBC134289CABAB043F53A7

    # Install packages
    sudo add-apt-repository -y ppa:kartkrew/srb2kart
    sudo apt-get -y update
    sudo apt-get -y install srb2kart
fi


# Check if mods are installed
if test -f /root/.srb2kart/kartserv.cfg
then
    echo "kartserv.cfg found, skipping mod installation"
else
    # Install mods

    # Create kartserv.cfg
    # kartserv.cfg is read on startup

    # This directory would be automatically created on first run of srb2kart
    # But we need to put stuff in it before first boot
    mkdir /root/.srb2kart/
    # It must be located in /root/.srb2kart/kartserv.cfg (assuming running as root)
    echo "addfile hornmod.pk3" > /root/.srb2kart/kartserv.cfg

    # Download hornmod.pk3
    # TODO take as env var?
    curl https://www.nickgirardo.com/hornmod.pk3 > /usr/games/SRB2Kart/hornmod.pk3
fi

# TODO install custom horns
# TODO update config file with custom horns

# Start server
srb2kart -dedicated
