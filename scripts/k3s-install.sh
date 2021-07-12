#!/usr/bin/env bash
#
# A simple script setting up K3s and FluxCD
#

# Connection parameters as first and second argument
machine_ip="$1"
machine_user="$2"
machine_connection="${machine_user}@${machine_ip}"

k3sup install \
    --host="${machine_ip}" \
    --user="${machine_user}" \
    --k3s-version=v1.20.5+k3s1 \
    --k3s-extra-args="--disable servicelb --disable traefik"

# Configure kubeconfig for connection
export KUBECONFIG=$(realpath kubeconfig)
kubectl config set-context default
kubectl get node -o wide
