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

# Install mods

# Check if kartserv.cfg exists
# kartserv.cfg is read on startup
# It must be located in /root/.srb2kart/kartserv.cfg (assuming running as root)
if test -f /root/.srb2kart/kartserv.cfg
then
    echo "kartserv.cfg exists, skipping creation"
else
    # This directory would be automatically created on first run of srb2kart
    # But we need to put stuff in it before first boot
    mkdir -p /root/.srb2kart/
    # Just creating a placeholder for now, will check for contents later
    touch /root/.srb2kart/kartserv.cfg
fi


# Install hornmod
if grep -q "addfile hornmod.pk3" /root/.srb2kart/kartserv.cfg; then
    echo "hornmod enabled, skipping download"
else
    # Set the contents of kartserv.cfg to the following string
    # It is important that this mod comes first, all other mods must be appended after
    echo "addfile hornmod.pk3" > /root/.srb2kart/kartserv.cfg

    # Download hornmod.pk3
    # TODO take as env var?
    curl https://www.nickgirardo.com/hornmod.pk3 > /usr/games/SRB2Kart/hornmod.pk3
fi


# Install hornpack (custom horns for hornmod)
# TODO maybe check hornmod is installed here as that must happen first?
if grep -q "addfile hornpack.pk3" /root/.srb2kart/kartserv.cfg; then
    echo "hornpack enabled, skipping download"
else
    # Appending this mod
    # It relies on hornmod and must come afterwards
    echo "addfile hornpack.pk3" >> /root/.srb2kart/kartserv.cfg

    # Download hornpack.pk3
    # TODO take as env var?
    curl https://www.nickgirardo.com/hornpack.pk3 > /usr/games/SRB2Kart/hornpack.pk3
fi

# Start server
srb2kart -dedicated
