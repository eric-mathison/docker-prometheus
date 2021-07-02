# Prometheus Docker Image

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/eric-mathison/docker-prometheus/Build%20Docker%20Image%20and%20Push?style=for-the-badge)

This image is based off the official [Prometheus](https://hub.docker.com/r/prom/prometheus/) Docker image. Some versions ago, the offical image changed the user to `nobody`. This modified image retracts that change and allows prometheus to run as `root` allowing prometheus to communicate with the host node using unix sockets.

## How to Use this Image

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

### GH Actions

This repo is configured to automatically build this Docker image and upload it to your Docker Hub account.

1. To setup this action, you need to set the following enviroment secrets:

-   `DOCKERHUB_USERNAME` - this is your Docker Hub username
-   `DOCKERHUB_TOKEN` - this is your Docker Hub API key

2. You need to update the tags for the build in `/.github/workflows/deploy.yml` on line 26.
