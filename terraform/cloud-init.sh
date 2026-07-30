#!/bin/bash

set -e

# Detect OS family and install stress tool
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        debian|ubuntu|linuxmint|pop)
            sudo apt-get update
            sudo apt-get install -y stress-ng
            ;;
        rhel|centos|rocky|almalinux|fedora)
            sudo yum install -y stress-ng || sudo dnf install -y stress-ng
            ;;
        *)
            echo "Unsupported OS: $ID"
            exit 1
            ;;
    esac
else
    echo "Unable to detect OS"
    exit 1
fi

# Check Installation
if command -v stress-ng >/dev/null 2>&1; then
    echo "Stresser installed"

    # Stresser cron job running every 2 hours
    echo "0 * * * * root $(command -v stress-ng) --cpu 4 --timeout 60s" | sudo tee /etc/cron.d/stresser >/dev/null
    sudo chmod 0644 /etc/cron.d/stresser
    sudo daemon-reload
else
    echo "Stresser uninstalled successfully"
fi

stress-ng --cpu 4 --timeout 20s

