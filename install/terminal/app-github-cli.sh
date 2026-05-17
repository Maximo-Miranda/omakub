#!/bin/bash

if ! apt-cache policy gh | grep -q 'Candidate: (none)'; then
    sudo apt install gh -y
    return 0 2>/dev/null || exit 0
fi

if [ ! -f /etc/apt/sources.list.d/github-cli.list ]; then
    [ -f /usr/share/keyrings/githubcli-archive-keyring.gpg ] && sudo rm /usr/share/keyrings/githubcli-archive-keyring.gpg
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg status=none
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
fi

sudo apt update
sudo apt install gh -y