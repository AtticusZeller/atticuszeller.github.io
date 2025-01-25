# Docker

## [Install Docker and Compose](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

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

- _Containers_ Created from Docker images and run the actual application. We create a container using `docker run`. A list of running containers can be seen using the `docker ps` command.
- _Images_ The blueprints of our application which form the basis of containers.
- _Docker Daemon_ The background service running on the host that manages building, running and distributing Docker containers. The daemon is the process that runs in the operating system which clients talk to.
- _Docker Client_ The command line tool that allows the user to interact with the daemon. More generally, there can be other forms of clients too - such as [docker-desktop](https://www.docker.com/products/docker-desktop/) which provide a GUI to the users.
- _Docker Hub_ A [registry](https://hub.docker.com/explore/) of Docker images. You can think of the registry as a directory of all available Docker images. If required, one can host their own Docker registries and can use them for pulling images.
- The `TAG` refers to a particular __snapshot__ of the image and the `IMAGE ID` is the corresponding unique __identifier__ for that image.

## Docker Image

An important distinction to be aware of when it comes to images is the difference between base and child images.

- __Base images__ are images that have no parent image, usually images with an OS like ubuntu, busybox or debian.
- __Child images__ are images that build on base images and add additional functionality.

Then there are official and user images, which can be both base and child images.

- __Official images__ are images that are officially maintained and supported by the folks at Docker. These are typically one word long. In the list of images above, the `python`, `ubuntu`, `busybox` and `hello-world` images are official images.
- __User images__ are images created and shared by users like you and me. They build on base images and add additional functionality. Typically, these are formatted as `user/image-name`.

### Image Layers

container images are composed of layers. And each of these layers, once created, are immutable.
![[assets/Pasted image 20250113205117.png]]
Each layer in an image contains a set of file system __changes__ - additions, deletions, or modifications.

![[assets/Pasted image 20250114175758.png]]
This is beneficial because it allows layers to be __reused__ between images. Layers let you extend images of others by reusing their base layers, allowing you to add only the data that your application needs.

The new layer is able to be stacked by `Dockerfile` or `docker container commit -m <container> <image>` manually. And `docker image history <image>` offers image layers info.[^1]

```bash
IMAGE          CREATED              CREATED BY                               SIZE      COMMENT
c1502e2ec875   About a minute ago   /bin/bash                                33B       Add app
5310da79c50a   4 minutes ago        /bin/bash                                126MB     Add node
2b7cc08dcdbb   5 weeks ago          /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
<missing>      5 weeks ago          /bin/sh -c #(nop) ADD file:07cdbabf782942af0â¦   69.2MB
<missing>      5 weeks ago          /bin/sh -c #(nop)  LABEL org.opencontainers.â¦   0B
<missing>      5 weeks ago          /bin/sh -c #(nop)  LABEL org.opencontainers.â¦   0B
<missing>      5 weeks ago          /bin/sh -c #(nop)  ARG LAUNCHPAD_BUILD_ARCH     0B
<missing>      5 weeks ago          /bin/sh -c #(nop)  ARG RELEASE                  0B
```

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

`ENV <name> <value>` - this instruction sets an environment variable that a running container will use.

```bash
# Ensure virtual environment binaries are in PATH： https://docs.astral.sh/uv/guides/integration/docker/#using-the-environment
ENV PATH="/app/.venv/bin:$PATH"
```

#### [Shell and exec form](https://docs.docker.com/reference/dockerfile/#shell-and-exec-form)

The `RUN`, `CMD`, and `ENTRYPOINT` instructions all have two possible forms:

- `INSTRUCTION ["executable","param1","param2"]` (exec form)
- `INSTRUCTION command param1 param2` (shell form)

> [!NOTE]
> - The exec form makes it possible to avoid shell string munging, because it is parsed as a JSON array.
> - The shell form always use a command shell and is parsed as a regular string, so it's more relaxed and inherits shell feature directly.

for example, `$HOME` can not be parsed as string `"$HOME"` but replaced by shell.
 on the contrary, we need to specify a command shell, or any other executable while using environment variables

 ```Dockerfile
 ENTRYPOINT ["/bin/bash", "-c", "echo hello"]
 ```

> [!TIP]
> - The Exec form is best used to specify `ENTRYPOINT` and `CMD` instructions for settings of default arguments that can be overridden at runtime.And it also stops container [quicker](https://docs.docker.com/compose/support-and-feedback/faq/#why-do-my-services-take-10-seconds-to-recreate-or-stop) while running `docker compose stop`.
> - The Shell form is most commonly used in `RUN` command, it lets you easier break long command in multiple lines with __backslash__

```Dockerfile
RUN source $HOME/.bashrc && \
echo $HOME
```

`RUN [OPTIONS] <command>` - this instruction tells the builder to run the specified command.
and creates a new layer on top of current layer. The [available](https://docs.docker.com/reference/dockerfile/#run) `[OPTIONS]` is helpful for accelerating the building process.

```Dockerfile
# Install dependencies
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers
RUN --mount=type=cache,target=/root/.cache/uv \
--mount=type=bind,source=uv.lock,target=uv.lock \
--mount=type=bind,source=pyproject.toml,target=pyproject.toml \
uv sync --frozen --no-install-project
```

`ENTRYPOINT ["executable", "param1", "param2"]` - it allows you to configure a container that run as executable. command line arguments to `docker run <image>` will be appended after all elements in an exec form of `ENTRYPONIT`, and will __override all__ elements specified using `CMD`, so will the commands in `compose.yml`.

`CMD` instruction sets the command to be executed when running a container from an image.
- `CMD ["executable","param1","param2"]` (exec form)
- `CMD ["param1","param2"]` (exec form, as default parameters to `ENTRYPOINT`)

> [!tip]
> we primarily use `CMD` to . Because it's much clearer for us to override it while debugging. Nobody wanna see something ugly like:
> ```yaml
> services:
> 	backend:
> 	    restart: "no"
> 	    ports:
> 	      - "8000:8000"
> 	    build:
> 	      context: ./backend
> 	    command:
> 	      - run
> 	      - --reload
> 	      - "app/main.py"
> ```
> there is no head of the `command`, quite scary.

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
> - Once one layer is invalidated, all following layers are also invalidated. [^2]

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

If a layer changes, all other layers that come after it are also affected.
![[assets/Pasted image 20250113205156.png]]

Best practice ?

we hope the layer frequently modified to be last one,which aims to prevent to take much time on rebuilding the other layers such as installing dependency.

[Intermediate layers](https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers) and [template](https://github.com/AtticusZeller/python-uv/blob/main/Dockerfile)

#### Multi-stage Builds

For compiled languages,like C or Go or Rust, multi-stage builds let you compile in one stage and copy the compiled binaries into a final runtime image. No need to bundle the entire compiler in your final image.[^3]

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

## Docker Container

### Run

`docker run` is aliases of `docker container run [OPTIONS] IMAGE [COMMAND] [ARG…]`,which defines how to create and run a new container from image.

> [!warning] Important
> While `docker run` is a convenient tool for launching container,it becomes difficult to manage a growing application stack with it. That's where `Docker Compose` comes to rescue.

### Network

#### Bridge

When docker is installed, it creates __three__ networks automatically.

```bash
docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
1f50a9c659fd   bridge    bridge    local
af3e60c1b1c0   host      host      local
534df30aa391   none      null      local
```

> [!cite]- host and none network
> The latter two are not fully-fledged networks, but are used to start a container connected directly to the Docker daemon host's networking stack, or to start a container with no network devices. This tutorial will connect two containers to the `bridge` network.[^4]

if you have not specified any `--network` flags, the containers connect to the __default__ `bridge` network, which can not ___resolve a container name to an IP address___,but it works for __user-defined__ networks,[^5]and containers will connect to the same user-defined networks bridge which created by docker compose.

> [!note]
> Automatic service discovery can only resolve __custom container names__, not default automatically generated container names[^5]
> `docker run --name <custom_container_name>` == the service name of `compose.yml` [^6]

docker container is designed as network isolation, __publishing a port__ provides the ability to connect or communicate other containers or be accessed by host machine.

```yaml
services:
  app:
    image: docker/welcome-to-docker
    ports:
      #- HOST_PORT:CONTAINER_PORT
      - 8080:80
```

#### Host

If you use the `host` network mode for a container, that container's network stack __isn't isolated__ from the Docker host (the container __shares__ the host's networking namespace), and the container doesn't get its own IP-address allocated.[^7]

### Volume

Volumes are a storage mechanism that provide the ability to __persist__ data __beyond__ the lifecycle of an individual container.[^8]so it can be shared by other or _old_ containers.

### [Sharing files between a host and container](https://docs.docker.com/get-started/docker-concepts/running-containers/sharing-local-files/#sharing-files-between-a-host-and-container)

```bash
docker run -v /HOST/PATH:/CONTAINER/PATH -it nginx
```

### Docker Compose

****
![[assets/Pasted image 20250125163300.png]][^9]
Docker Compose defines your entire __multi-container__ application in a single `YAML` file called `commpose.yml`. The file specifies configuration for all your containers,their dependencies, environment variables, and even volumes and networks.[^10]

#### Configuration

There are __3__ ways for `docker compose` to read configs, merge, extend, include.,[^11] __merge__ configs is most widely used while developing, extend and include are suitable for multiple services or teams.

Default behavior of `docker compose up`? Compose read __2__ files, a `compose.yaml` and an optional `compose.override.yaml` file. By convention, the `compose.yaml` contains your __base__ configuration. The override file can contain configuration __overrides__ for existing services or entirely __new__ services.[^12]

> [!example] Strategy Use a two-file approach for different environments
> 1. `compose.yml`: Main configuration for production
> 	- Run with: `docker compose -f compose.yml up -d`
> 1. `compose.override.yml`: Override file for development
> 	- Automatically used with: `docker compose up -d`
>
> This strategy allows you to maintain a base configuration for production while easily switching to a development setup with overrides.[^13]

what if i don't like default behavior? To specify or merge multiple configs use `docker compose -f <config_path> up`.[^14]

> [!Note]
> Paths are evaluated relative to the __base file__. When you use multiple Compose files, you must make sure all paths in the files are relative to the base Compose file (the first Compose file specified with `-f`).[^14]

how to merge? precedence?
- For __single-value__ options like `image`, `command` or `mem_limit`, the new value replaces the old value.
- For the __multi-value__\(list\) options `ports`, `expose`, `external_links`, `dns`, `dns_search`, and `tmpfs`, Compose __concatenates__ both sets of values.
- For __key-value__ options `environment`, `labels`, `volumes`, and `devices`, Compose "merges" entries together with __locally__ defined values taking precedence.[^15]

> [!tip] `compose.yaml` or `docker-compose.yaml`?
> The default path for a Compose file is `compose.yaml` (preferred) or `compose.yml` that is placed in the working directory. Compose also supports `docker-compose.yaml` and `docker-compose.yml` for backwards compatibility of __earlier__ versions. If both files exist, Compose prefers the __canonical__ `compose.yaml`.[^16]

> [!TIP] Dockerfile versus Compose file
> A Dockerfile provides instructions to _build a container image_ while a Compose file _defines your running containers_. Quite often, a Compose file references a Dockerfile to build an image to use for a particular service.[^17]

#### Project name

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

[^1]: https://docs.docker.com/get-started/docker-concepts/building-images/understanding-image-layers/#stacking-the-layers
[^2]: https://docs.docker.com/get-started/docker-concepts/building-images/using-the-build-cache/
[^3]: https://docs.docker.com/get-started/docker-concepts/building-images/multi-stage-builds/#explanation)
[^4]: https://docs.docker.com/engine/network/tutorials/standalone/#use-the-default-bridge-network
[^5]: https://docs.docker.com/engine/network/tutorials/standalone/#use-user-defined-bridge-networks
[^6]: https://docs.docker.com/compose/how-tos/networking/
[^7]: https://docs.docker.com/engine/network/drivers/host/
[^8]: https://docs.docker.com/get-started/docker-concepts/running-containers/persisting-container-data/
[^9]: https://docs.docker.com/compose/images/compose-application.webp
[^10]: https://docs.docker.com/get-started/docker-concepts/running-containers/multi-container-applications/#explanation
[^11]: https://docs.docker.com/compose/how-tos/multiple-compose-files/
[^12]: https://docs.docker.com/compose/how-tos/multiple-compose-files/merge/
[^13]: https://github.com/fastapi/full-stack-fastapi-template
[^14]: https://docs.docker.com/compose/how-tos/multiple-compose-files/merge/#how-to-merge-multiple-compose-files
[^15]: https://docs.docker.com/compose/how-tos/multiple-compose-files/merge/#merging-rules
[^16]: https://docs.docker.com/compose/intro/compose-application-model/#the-compose-file
[^17]: https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-docker-compose
