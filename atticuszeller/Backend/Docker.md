# Docker

## [Install Docker and - Compose](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# install docker engine
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

```bash
# tests
sudo docker run hello-world
docker compose version
```

## [Terminology](https://docker-curriculum.com/#terminology)

[A Docker Tutorial for Beginners](https://docker-curriculum.com)

- _Containers_  Created from Docker images and run the actual application. We create a container using `docker run`. A list of running containers can be seen using the `docker ps` command.
- _Images_  The blueprints of our application which form the basis of containers.
- _Docker Daemon_  The background service running on the host that manages building, running and distributing Docker containers. The daemon is the process that runs in the operating system which clients talk to.
- _Docker Client_  The command line tool that allows the user to interact with the daemon. More generally, there can be other forms of clients too - such as [docker-desktop](https://www.docker.com/products/docker-desktop/) which provide a GUI to the users.
- _Docker Hub_   A [registry](https://hub.docker.com/explore/) of Docker images. You can think of the registry as a directory of all available Docker images. If required, one can host their own Docker registries and can use them for pulling images.
- The `TAG` refers to a particular __snapshot__ of the image and the `IMAGE ID` is the corresponding unique __identifier__ for that image.

## Docker Image

An important distinction to be aware of when it comes to images is the difference between base and child images.

- __Base images__ are images that have no parent image, usually images with an OS like ubuntu, busybox or debian.
- __Child images__ are images that build on base images and add additional functionality.

Then there are official and user images, which can be both base and child images.

- __Official images__ are images that are officially maintained and supported by the folks at Docker. These are typically one word long. In the list of images above, the `python`, `ubuntu`, `busybox` and `hello-world` images are official images.
- __User images__ are images created and shared by users like you and me. They build on base images and add additional functionality. Typically, these are formatted as `user/image-name`.

### Image Layers

### [Dockerfile](https://docs.docker.com/reference/dockerfile/)

A [Dockerfile](https://docs.docker.com/engine/reference/builder/) is a simple text file that contains a list of commands that the Docker client calls while creating an \(child\) __image__.

`FROM <image>` - this specifies the _base image_ that the build will extend.

```bash
# base image from bookworm=debian12 with slim python
FROM python:3.12-slim-bookworm
```

`WORKDIR <path>` - this instruction specifies the "working directory" or the path in the image where files will be copied and commands will be executed.

```bash
# set a directory for the app
WORKDIR /app
```

`COPY <host-path> <image-path>` - this instruction tells the builder to copy files from the host and put them into the container image.

```bash
# copy all the files to the $(pwd)
COPY . .
```

`RUN <command>` - this instruction tells the builder to run the specified command.

```bash
CMD ["python", "./app.py"]
```

`ENV <name> <value>` - this instruction sets an environment variable that a running container will use.

```bash
# Ensure virtual environment binaries are in PATH： https://docs.astral.sh/uv/guides/integration/docker/#using-the-environment
ENV PATH="/app/.venv/bin:$PATH"
```

### Docker Build

This username should be the same one you created when you registered on [Docker hub](https://hub.docker.com/).
it takes an optional tag name with `-t` and a location of the directory containing the `Dockerfile`.

```bash
docker build -t yourusername/hello-world .
```

> copy `.gitignore` to `.dockerignore` to slim the `/app`

#### Cache

> [!TIP] Using the build cache
> Using the build cache effectively lets you achieve faster builds by reusing results from previous builds and skipping unnecessary work.
> - Any changes to the command of a `RUN` instruction invalidates that layer.
> - Any changes to files copied into the image with the `COPY` or `ADD` instructions.
> - Once one layer is invalidated, all following layers are also invalidated.[\[1\]](https://docs.docker.com/get-started/docker-concepts/building-images/using-the-build-cache/)

[How it works?](https://docs.docker.com/build/cache/)

```Dockerfile
# syntax=docker/dockerfile:1
FROM ubuntu:latest

RUN apt-get update && apt-get install -y build-essentials
COPY main.c Makefile /src/
WORKDIR /src/
RUN make build
```

Each instruction in this Dockerfile translates to a layer in your final image.
![[assets/Pasted image 20250113205117.png]]

If a layer changes, all other layers that come after it are also affected.
![[assets/Pasted image 20250113205156.png]]

Best practice ?

we hope the layer frequently modified to be last one,which aims to prevent to take much time on rebuilding the other layers such as installing dependency.

[Intermediate layers](https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers) and [template](https://github.com/AtticusZeller/python-uv/blob/main/Dockerfile)

#### Multi-stage Builds

For compiled languages,like C or Go or Rust, multi-stage builds let you compile in one stage and copy the compiled binaries into a final runtime image. No need to bundle the entire compiler in your final image.[\[2\]](https://docs.docker.com/get-started/docker-concepts/building-images/multi-stage-builds/#explanation)

```Dockerfile
# Stage 1: Build Environment
FROM builder-image AS build-stage
# Install build tools (e.g., Maven, Gradle)
# Copy source code
# Build commands (e.g., compile, package)

# Stage 2: Runtime environment
FROM runtime-image AS final-stage
#  Copy application artifacts from the build stage (e.g., JAR file)
COPY --from=build-stage /path/in/build/stage /path/to/place/in/final/stage
# Define runtime configuration (e.g., CMD, ENTRYPOINT)
```

### Docker Run

```bash
docker run yourusername/hello-world:latest
```

### Docker Push

If this is the first time you are pushing an image, the client will ask you to login. Provide the same credentials that you used for logging into Docker Hub.

```bash
docker login
```

It is important to have the format of `yourusername/image_name` so that the client knows where to publish.

```bash
docker push yourusername/hello-world
```

Now that your image is online, anyone who has docker installed can play with your app by typing just a single command.

## Docker Compose

> [!TIP] Dockerfile versus Compose file
> A Dockerfile provides instructions to _build a container image_ while a Compose file _defines your running containers_. Quite often, a Compose file references a Dockerfile to build an image to use for a particular service.[\[3\]](https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-docker-compose/)

### Commands

```bash
docker compose down && docker compose up -d
```

## Docker Commands

### Use Docker by User without `sudo`

[Post-installation steps | Docker Docs](https://docs.docker.com/engine/install/linux-postinstall/)

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# tests
docker run hello-world
```

### Auto Start

```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

### Check the Running Container

```bash
# ps= process status,show running containers
docker ps
# show containers that are running or exited
docker ps -a
```

### [Usage and rate limits \| Docker Docs](https://docs.docker.com/docker-hub/download-rate-limit/#how-do-i-authenticate-pulls)

```bash
docker login
```

### Remove Containers

deletes all containers that have a status of `exited

```bash
docker container prune
```

### Remove Image

```bash
docker rmi <image_id>
```

## Linter

```bash
brew install hadolint
```
