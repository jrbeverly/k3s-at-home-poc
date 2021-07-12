# Configuration Files

Configuration and secret files that need to exist within the cluster.

## Getting Started

Run

```bash
kubectl create ns cert-manager
```

Then apply the cloudflare token with the appropriate token filled in.

```bash
kubectl apply -f config/
```