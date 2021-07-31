# Prometheus Docker Image

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/eric-mathison/docker-prometheus/Build%20Docker%20Image%20and%20Push?style=for-the-badge)

This image is based off the official [Prometheus](https://hub.docker.com/r/prom/prometheus/) Docker image. The configuration file is configured to use a `static` configuration rather than the `docker discovery`. This is to allow prometheus to be connected to additional nodes located inside a **private network**.

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

### Prometheus Configuration

A configuration file `./prometheus.yml` is provided and may be updated with your own scrape configs. The present config is currently configured for `Static Hosts` and listening for `CAdvisor`, `Node Exporter`, and `Docker Daemon Metrics`.

### GH Actions

This repo is configured to automatically build this Docker image and upload it to your Docker Hub account.

1. To setup this action, you need to set the following enviroment secrets:

-   `DOCKERHUB_USERNAME` - this is your Docker Hub username
-   `DOCKERHUB_TOKEN` - this is your Docker Hub API key

2. You need to update the tags for the build in `/.github/workflows/deploy.yml` on line 26.
