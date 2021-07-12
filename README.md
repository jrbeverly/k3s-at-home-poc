# K3s In HomeLab Proof of Concept

Determining how viable it would to be switch from using docker-compose to using K3s to run my internal homelab environment.

## Getting Started

The installation process assumes that you have a freshly imaged ubuntu machine, connected to the internal network, and with a minimum of password-based SSH access.

### Installing dependencies

The tools FluxCD & K3sup can be installed on the host machine using the script `setup.sh` (scripts/setup.bash). This can be done like so: 

```bash
bash scripts/setup.bash
```

When this is completed, you should have K3sup and flux installed in your environment.

### Setting up SSH keys for K3sup

To setup SSH keys for K3sup, you can run the script `ssh-for-fresh.sh` (scripts/ssh-for-fresh.sh), that will create an SSH key pair, copy it to the machine, and adjust the SSH configurations (both on host+machine) to expect SSH keys for connections.

You only need this for the install of k3sup, and can allow password-based login again after install.

```bash
bash scripts/ssh-for-fresh.sh <ip> <user>
```

### Installing K3s on the machine

You can perform the installation for the machine by running the script `k3s-install.sh` (scripts/k3s-install.sh). You can do that like so:

```bash
bash scripts/k3s-install.sh <ip> <user> 
```

### Installing FluxCD on the cluster

You can perform the installation for the cluster by running the script `fluxcd-install.sh` (scripts/fluxcd-install.sh). You can do that like so:

```bash
bash scripts/k3s-install.sh <name of cluster> <github username> <github repository name (to be created)> 
```

This will create the github repository with the basic fluxcd configuration setup.

### Setting up the configuration

Follow the steps in the `config/` directory to get your config+secrets configured in the cluster.

### Copying in the Kustomizations

Copy in all of the Kustomization yaml files located in this directory under `clusters/homelab/`. These setup the cluster with a series of namespaces/CRD/networking/certs. These are all configured with the `jrbeverly.dev` domain for prototyping.

For the domain resolution to work, you'll need to manually create the domains as they exist in the YAML in Cloudflare.

## Notes

- GitPod installation did not work as desired
- Setting up services like require cross-talk in terms of filesystems would likely be high overhead
- Layout of directories could use some improvement (same with naming)
- Secrets management could be simplified, but what is the best way to handle this?
- GitHub private repositories are supported by leveraging FluxCD Bootstrap instead of manually setting it up
- Using `kubectl get secrets` you can find the `Opaque` secret created for the Deploy Key with FluxCD Bootstrap (& rotate/change it)
- Initial setup for this requires a GitHub Personal Access Token (PAT) to be created, but can be removed when Deploy Keys are configured
- If the deploy keys disappear from GitHub, you can retrieve them from the secret in K3s (`kubectl get secrets`), then upload to GitHub.
