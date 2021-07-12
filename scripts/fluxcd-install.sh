#!/usr/bin/env bash
#
# A simple script setting up K3s and FluxCD
#

# Connection parameters as first and second argument
cluster_name="$1"
github_user="$2"
github_repo="$3"

# Create the FluxCD namespace on the system
kubectl create ns flux-system
kubectl get ns

flux bootstrap github \
  --owner="${github_user}" \
  --repository="${github_repo}" \
  --branch=main \
  --path=./clusters/${name} \
  --personal
