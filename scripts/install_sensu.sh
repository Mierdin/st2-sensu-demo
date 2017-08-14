#!/bin/bash

# Some taken from https://sensuapp.org/docs/0.23/quick-start/the-five-minute-install.html
# Also cannibalized their install script to be touchless

cd ~

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo, or as root"
    exit 1
fi

grep -i 'ubuntu\|debian' /etc/issue > /dev/null 2>&1
issue=$?
if [ $issue -ne 0 ]; then
    echo "This script must be run on Ubuntu or Debian only"
    exit 1
fi

# update apt, install depenedencies
echo "Installing dependencies..."
apt-get install -y curl > /dev/null


install_core ()
{
    echo "...installing the Sensu Core software repository..."
    wget -q http://repositories.sensuapp.org/apt/pubkey.gpg -O- | apt-key add - > /dev/null 2>&1
    echo "deb     http://repositories.sensuapp.org/apt sensu main" | tee /etc/apt/sources.list.d/sensu.list > /dev/null 2>&1
    echo "SUCCESS!"
    success=1
}
install_core
if [[ $success -eq 1 ]]; then
   echo "Thank you for using Sensu! #monitoringlove"
fi

sudo apt-get update
sudo apt-get -y install redis-server curl jq
sudo update-rc.d redis-server defaults
sudo /etc/init.d/redis-server restart
sudo apt-get install sensu

sudo wget -O /etc/sensu/config.json https://sensuapp.org/docs/0.23/files/simple-sensu-config.json
sudo wget -O /etc/sensu/conf.d/client.json https://sensuapp.org/docs/0.23/files/simple-client-config.json
sudo wget -O /etc/sensu/dashboard.json https://sensuapp.org/docs/0.23/files/simple-dashboard-config.json
sudo chown -R sensu:sensu /etc/sensu
sudo /etc/init.d/sensu-server start
sudo /etc/init.d/sensu-api start
sudo /etc/init.d/sensu-client start