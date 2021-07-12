#!/usr/bin/env bash

echo "Installing K3sup from source"
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/

echo "Installing fluxcd from source"
curl -s https://fluxcd.io/install.sh | sudo bash
