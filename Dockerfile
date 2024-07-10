# Ubuntu 20.04 is OS expo use in cloud to build the apps.
FROM ubuntu:20.04

LABEL maintainer="vitor.roberto3022@gmail.com"

# update the package list and install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg

# add NodeSource APT repository for Node.js
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -

# install Node.js (include)
RUN apt-get install -y nodejs

# install yarn (optional)
RUN npm install -g yarn 

# install expo dependencies
RUN npm install -g eas-cli
RUN npm install -g sharp-cli

# install git (eas-cli require git, but you can disable it setting `EAS_NO_VCS=1`) 
RUN apt-get -y install git

# setup folder to store the expo apps
RUN mkdir -p /home/expo_apps/

# install android studio and java dependencies
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y
RUN apt-get install -y build-essential wget unzip make sudo
RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
RUN apt-get install -y libxrender1 libxtst6 libxi6 libfreetype6 libxft2 xz-utils
RUN apt-get install -y qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils libnotify4 libglu1-mesa libqt5widgets5
RUN apt-get install -y openjdk-8-jdk openjdk-11-jdk xvfb

# Get SDK tools (link from https://developer.android.com/studio/index.html#downloads)
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN tar xf android-sdk*-linux.tgz

# Get NDK (https://developer.android.com/ndk/downloads/index.html)
RUN wget https://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip
RUN unzip android-ndk*.zip

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
RUN unzip commandlinetools-linux-9477386_latest.zip
RUN yes | /cmdline-tools/bin/sdkmanager --licenses

RUN sudo /android-sdk-linux/tools/android update sdk --no-ui
RUN sudo /android-sdk-linux/tools/android update sdk --all --no-ui --filter $(seq -s, 27)

# Add the directory containing executables in PATH so that they can be found
RUN echo 'export ANDROID_HOME=/android-sdk-linux' >> ~/.bashrc
RUN echo 'export ANDROID_SDK_ROOT=/android-sdk-linux' >> ~/.bashrc
RUN echo 'export PATH=$PATH:/tools:$ANDROID_HOME/platform-tools' >> ~/.bashrc
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc
RUN echo 'export ANDROID_NDK_HOME=/android-ndk-r12b' >> ~/.bashrc
RUN source ~/.bashrc

RUN echo y | $ANDROID_HOME/tools/android update sdk --all --filter build-tools-21.1.0 --no-ui
RUN yes | /cmdline-tools/bin/sdkmanager --licenses --sdk_root=$ANDROID_SDK_ROOT

# Optionally run build system as daemon (speeds up build process)
RUN mkdir ~/.gradle
RUN echo 'org.gradle.daemon=true' >> ~/.gradle/gradle.properties


# RUN mkdir -p /androidstudio-data
# VOLUME /androidstudio-data
# RUN chown $USER:$USER /androidstudio-data

# RUN mkdir -p /studio-data/Android/Sdk && \
#     chown -R $USER:$USER /studio-data/Android


# RUN mkdir -p /studio-data/profile/android && \
#     chown -R $USER:$USER /studio-data/profile

# ARG ANDROID_STUDIO_URL=https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.3.1.20/android-studio-2022.3.1.20-linux.tar.gz
# ARG ANDROID_STUDIO_VERSION=2022.3.1.20

# RUN wget "$ANDROID_STUDIO_URL" -O android-studio.tar.gz
# RUN tar xzvf android-studio.tar.gz
# RUN rm android-studio.tar.gz

# RUN ln -s /studio-data/profile/AndroidStudio$ANDROID_STUDIO_VERSION .AndroidStudio$ANDROID_STUDIO_VERSION
# RUN ln -s /studio-data/Android Android
# RUN ln -s /studio-data/profile/android .android
# RUN ln -s /studio-data/profile/java .java
# RUN ln -s /studio-data/profile/gradle .gradle
# ENV ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
