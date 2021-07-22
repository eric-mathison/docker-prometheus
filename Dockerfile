FROM prom/prometheus:v2.28.0

RUN addgroup -S docker && adduser -S docker -G docker

COPY prometheus.yml /etc/prometheus/prometheus.yml

USER docker