#!/bin/bash
wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb
sudo apt install ./steam.deb -y
rm steam.deb
