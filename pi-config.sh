#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# change the host name
raspi-config nonint do_hostname lobo

# Set a static address for the eth0 LAN interface
echo "
interface eth0
static ip_address=192.168.0.4/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1 8.8.8.8 fd51:42f8:caae:d92e::1
" >> /etc/dhcpcd.conf

# install some additional packages
apt-get update
curl -sSL https://get.docker.com | sh
apt-get install -y git docker-compose

# get config file
cd /root
git clone https://github.com/xmayeur/pi_scripts.git
usermod -aG docker pi
sh ./run.sh'

echo "Warning: do not forget to copy the vault database where it should"
echo "Please re-boot now"




