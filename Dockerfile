FROM prom/prometheus:v2.28.0

RUN rm -f /etc/prometheus/prometheus.yml
COPY prometheus.yml /etc/prometheus/