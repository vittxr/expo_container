# Docker commands

1. Build the image 

```bash
docker build -t expo .
```

2. Run the container 

```bash
docker run -it --name expo_container expo 
```

# Build expo app 

## Copy the files from your host machine to the container

You should transfer your expo app files inside the container with:

```bash
docker cp /path/to/file expo_container:/home/expo_apps/
```

> [!TIP]
> Copy files from you host machine to docker container may be very slow, because it copies bit by bit of the files. Instead of copying files, you can clone the github repository and install the dependencies inside docker container.

## Set compile versions in your expo app 

To build the app locally, you need to set some [build properties](https://docs.expo.dev/versions/v49.0.0/sdk/build-properties/). 

1. Install expo-build-properties
   
```bash
npx expo install expo-build-properties
```

2. set android and ios properties in `app.json`

```json
{
  "expo": {
    "plugins": [
      [
        "expo-build-properties",
        {
          "android": {
            "compileSdkVersion": 31,
            "targetSdkVersion": 31,
            "buildToolsVersion": "31.0.0"
          },
          "ios": {
            "deploymentTarget": "13.0"
          }
        }
      ]
    ]
  }
}
```

## Build

Inside container CLI, run the following command to build the expo app:

```bash
cd /home/expo_apps/your_app
yarn install
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