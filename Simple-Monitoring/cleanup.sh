#!/bin/bash

echo "Removing Netdata..."

if [ -f /usr/libexec/netdata/netdata-uninstaller.sh ]; then
    sudo /usr/libexec/netdata/netdata-uninstaller.sh --yes
elif command -v apt >/dev/null 2>&1; then
    sudo apt purge netdata netdata-core netdata-plugins-bash -y
    sudo apt autoremove -y
else
    echo "Netdata uninstaller was not found."
fi

sudo rm -rf /etc/netdata
sudo rm -rf /var/lib/netdata
sudo rm -rf /var/cache/netdata
sudo rm -rf /var/log/netdata

echo "Netdata cleanup completed."