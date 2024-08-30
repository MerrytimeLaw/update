#!/bin/bash

# Update the system
source ~/.bashrc

# Update apt
sudo apt update

# Upgrade with --yes flag to force yes
sudo apt upgrade --yes

# Check for kernel errors
if sudo dmesg | grep -i "error"; then
    echo "Kernel errors found!"
else
    echo "No kernel errors found."
fi

exit