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
docker ps
```

### [Usage and rate limits \| Docker Docs](https://docs.docker.com/docker-hub/download-rate-limit/#how-do-i-authenticate-pulls)

```bash
docker login
```
