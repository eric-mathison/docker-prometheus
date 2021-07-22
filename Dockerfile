FROM prom/prometheus:v2.28.0

COPY prometheus.yml /etc/prometheus/prometheus.yml

USER docker