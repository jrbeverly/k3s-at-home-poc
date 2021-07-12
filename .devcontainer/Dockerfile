FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu
RUN apt-get update
RUN apt-get install -y zsh && \
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN curl -sLS https://get.k3sup.dev | sh && \
    sudo install k3sup /usr/local/bin/

RUN curl -s https://fluxcd.io/install.sh | sudo bash