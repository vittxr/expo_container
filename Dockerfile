FROM ubuntu:22.04

LABEL maintainer="vitor.roberto3022@gmail.com"

# update the package list and install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    build-essential

# add NodeSource APT repository for Node.js
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -

# install Node.js and NPM
RUN apt-get install -y nodejs

# install yarn (optional)
RUN npm install -g yarn

# install eas-cli 
RUN npm install -g eas-cli

# install git (eas-cli require git, but you can disable it setting `EAS_NO_VCS=1`) 
RUN apt-get -y install git

# setup folder to store the expo apps
RUN mkdir -p /home/expo_apps/

