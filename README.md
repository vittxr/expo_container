# Summary

Expo does not officially support local EAS builds on Windows:

> On Windows, you can use WSL for local EAS Builds. However, we do not officially test against this platform and do not support Windows for local builds (macOS and Linux are supported).

If you're a Windows developer who wants to run local Expo EAS builds without relying on cloud build credits, this project provides a Docker-based solution that makes it possible.

While Expo's cloud builds are generally the recommended approach, free build quotas can be limiting, especially during active development and testing. 

> [!NOTE]
> I don't work with expo anymore, so I'm not sure if this is working, but it might be something similar. 

# Docker commands

1. Build the image 

```bash
docker build -t expo .
```

2. Run the container 

```bash
docker run -it --name expo_container expo 
```

# Create expo app 

Inside container CLI, create your expo app:

```bash
npx create-expo-app StickerSmash --template blank
cd StickerSmash
npx expo install react-dom react-native-web @expo/metro-runtime
```

Build your app locally using:

```bash
eas build --platform android --local
```

# References

- [Local builds - EXPO](https://docs.expo.dev/build-reference/local-builds/)
- [Docker builds](https://docs.docker.com/reference/cli/docker/image/build/)
- [Docker containers](https://docs.docker.com/reference/cli/docker/container/run/)
- [Copy files from local machine to docker container](https://stackoverflow.com/questions/40313633/how-to-copy-files-from-local-machine-to-docker-container-on-windows)
- [Name docker container](https://docs.docker.com/engine/reference/run/#:~:text=Container%20identification,-You%20can%20identify&text=You%20can%20also%20defined%20a,background%20and%20foreground%20Docker%20containers.)
- [Disable git from eas-cli](https://expo.fyi/eas-vcs-workflow)
- [Android Studio + flutter in docker](https://github.com/Deadolus/android-studio-docker)
- [install-android-sdk.bash](https://gist.github.com/zhy0/66d4c5eb3bcfca54be2a0018c3058931)
- [speed up gradle build time - Tim Roes](https://www.timroes.de/speed-up-gradle)
- [libvirt-bin package was dropped in 18.10](https://askubuntu.com/a/1089849/1674603)
- [build-properties - Expo](https://docs.expo.dev/versions/v49.0.0/sdk/build-properties/)
- [Accept all sdk licenses](https://stackoverflow.com/questions/38096225/automatically-accept-all-sdk-licences)
- [Create your first app - Expo](https://docs.expo.dev/tutorial/create-your-first-app/)
