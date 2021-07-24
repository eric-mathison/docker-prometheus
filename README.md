# Prometheus Docker Image

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/eric-mathison/docker-prometheus/Build%20Docker%20Image%20and%20Push?style=for-the-badge)

This image is based off the official [Prometheus](https://hub.docker.com/r/prom/prometheus/) Docker image. Some versions ago, the offical image changed the user to `nobody` which prevents prometheus from being able to communicate with the Docker Daemon socket. This image uses [Docker-Socket-Proxy](https://github.com/Tecnativa/docker-socket-proxy) to be able to securely access the Daemon socket.

## How to Use this Image

## Start a `Docker-Socket-Proxy` server instance

```bash
docker container run \
    -d --privileged \
    --name captain-socket-proxy \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 2375:2375 \
    tecnativa/docker-socket-proxy
```

or as a service if you are using `Docker Swarm`

```bash
docker service create --name captain-socket-proxy \
    --network captain-overlay-network \
    --publish 2375:2375 \
    --limit-memory 128M \
    --reserve-memory 64M \
    --mount type=bind,source=/var/run/docker.sock,dst=/var/run/docker.sock \
    --env SERVICES=1 \
    --env NODES=1 \
    --env TASKS=1 \
    --env NETWORKS=1 \
    tecnativa/docker-socket-proxy:latest
```

## Start a `Prometheus` server instance

```bash
docker run -p 9090 --name prometheus -d ericmathison/prometheus:tag
```

### Using Docker Compose

Example docker-compose.yml file:

```yaml
version: "3.3"

services:
    nginx:
        image: ericmathison/prometheus:latest
        restart: always
        volumes:
            - config:/etc/prometheus
            - data:/prometheus
```

## Configuration

### Prometheus Configuration

A configuration file `./prometheus.yml` is provided and may be updated with your own scrape configs. The present config is currently configured for a `Docker Swarm environment` and listening for `CAdvisor`, `Node Exporter`, and `Docker Daemon Metrics`.

### GH Actions

This repo is configured to automatically build this Docker image and upload it to your Docker Hub account.

1. To setup this action, you need to set the following enviroment secrets:

-   `DOCKERHUB_USERNAME` - this is your Docker Hub username
-   `DOCKERHUB_TOKEN` - this is your Docker Hub API key

2. You need to update the tags for the build in `/.github/workflows/deploy.yml` on line 26.
