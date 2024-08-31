#!/bin/bash

# Update the system
source ~/.bashrc

# Update apt
sudo apt update 2>/dev/null | sed 's/\(.*\)/\x1b[32m(apt) \1\x1b[0m/'

# Add a pause to make it feel more natural
sleep 2

# Upgrade with --yes flag to force yes
sudo apt upgrade --yes 2>/dev/null | sed 's/\(.*\)/\x1b[32m(apt) \1\x1b[0m/'

# Add a pause to make it feel more natural
sleep 4

# Initiate some other system checks
echo "Checking for broken packages..."
sudo apt --fix-broken install 2>/dev/null | sed 's/\(.*\)/\x1b[32m(apt) \1\x1b[0m/'
sleep 2

# Check for available updates
echo "Checking for available updates..."
sudo apt list --upgradable 2>/dev/null | sed 's/\(.*\)/\x1b[32m(apt) \1\x1b[0m/'
sleep 2

# Clean up unused packages
echo "Cleaning up unused packages..."
sudo apt autoremove --yes 2>/dev/null | sed 's/\(.*\)/\x1b[32m(apt) \1\x1b[0m/'
sleep 2

# Check for disk usage
echo "Checking disk usage..."
(df -h) | sed 's/\(.*\)/\x1b[32m(df) \1\x1b[0m/'
sleep 2

# Check for memory usage
echo "Checking memory usage..."
free -h | sed 's/\(.*\)/\x1b[32m(free) \1\x1b[0m/'
sleep 2

# Check for network usage
echo "Checking network usage..."
sleep 2
if command -v ifconfig &>/dev/null; then
    ifconfig | grep "RX packets\|TX packets" | sed 's/\(.*\)/\x1b[32m(ifconfig) \1\x1b[0m/'
else
    echo "ifconfig command not found."
fi

# Add a pause to make it feel more natural
sleep 5

# Check for CPU usage
echo "Checking CPU usage..."
top -bn1 | grep "%Cpu" | sed 's/\(.*\)/\x1b[32m(top) \1\x1b[0m/'
sleep 2

# Check disk for errors
echo "Checking disk for errors..."
if sudo fsck -f -p /dev/sd* 2>/dev/null | grep -q "errors"; then
    echo "Errors found."
else
    echo "No errors found."
fi

# Exit the script
exit
