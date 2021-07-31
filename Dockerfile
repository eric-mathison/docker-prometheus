FROM prom/prometheus:v2.28.0

USER root
RUN rm -rf /etc/prometheus/prometheus.yml
COPY prometheus.yml /etc/prometheus/
USER nobody