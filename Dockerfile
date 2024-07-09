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

# install eas-cli (for expo)
RUN npm install -g eas-cli

# install git (eas-cli require git, but you can disable it setting `EAS_NO_VCS=1`) 
RUN apt-get -y install git

# setup folder to store the expo apps
RUN mkdir -p /home/expo_apps/

RUN apt-get install wget

# install android studio
RUN mkdir -p /androidstudio-data
VOLUME /androidstudio-data
RUN chown $USER:$USER /androidstudio-data

RUN mkdir -p /studio-data/Android/Sdk && \
    chown -R $USER:$USER /studio-data/Android


RUN mkdir -p /studio-data/profile/android && \
    chown -R $USER:$USER /studio-data/profile

ARG ANDROID_STUDIO_URL=https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.3.1.20/android-studio-2022.3.1.20-linux.tar.gz
ARG ANDROID_STUDIO_VERSION=2022.3.1.20

RUN wget "$ANDROID_STUDIO_URL" -O android-studio.tar.gz
RUN tar xzvf android-studio.tar.gz
RUN rm android-studio.tar.gz

RUN ln -s /studio-data/profile/AndroidStudio$ANDROID_STUDIO_VERSION .AndroidStudio$ANDROID_STUDIO_VERSION
RUN ln -s /studio-data/Android Android
RUN ln -s /studio-data/profile/android .android
RUN ln -s /studio-data/profile/java .java
RUN ln -s /studio-data/profile/gradle .gradle
ENV ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
