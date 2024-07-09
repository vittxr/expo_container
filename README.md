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

You should transfer your expo app files inside the container with:

```bash
docker cp /path/to/file expo_container:/home/expo_apps/
```

and then, inside container CLI, run the following command to build the expo app:

```bash
cd /home/expo_apps/your_app
eas build --platform android --local
```

> [!TIP]
> Copy files from you host machine to docker container may be very slow, because it copies bit by bit of the files. Instead of cpy the files, you can clone the github repository and install the dependencies inside docker container.

# References

- [Local builds - EXPO](https://docs.expo.dev/build-reference/local-builds/)
- [Docker builds](https://docs.docker.com/reference/cli/docker/image/build/)
- [Docker containers](https://docs.docker.com/reference/cli/docker/container/run/)
- [Copy files from local machine to docker container](https://stackoverflow.com/questions/40313633/how-to-copy-files-from-local-machine-to-docker-container-on-windows)
- [Name docker container](https://docs.docker.com/engine/reference/run/#:~:text=Container%20identification,-You%20can%20identify&text=You%20can%20also%20defined%20a,background%20and%20foreground%20Docker%20containers.)
- [Disable git from eas-cli](https://expo.fyi/eas-vcs-workflow)