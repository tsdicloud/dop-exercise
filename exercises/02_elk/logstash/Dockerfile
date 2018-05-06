#
# this is the base image for different elk componente/services
# Baseimage: CentOS7 with systemd enabled
FROM 160.44.200.121:443/otc00000000001000000317/java8-centos7-base:1.8

LABEL maintainer="Bernd Rederlechner <bernd.rederlechner@t-systems.com>" \
      tsystems.project="CCE Devops Tutorial" \
      tsystems.application="ELK OBS general purpose stack"
#VOLUME ["/sys/fs/cgroup"]

#
# Install repo
# TODO: heck key checksum:
# && gpg --recv-keys GPG-KEY-elasticsearch \
WORKDIR /tmp
COPY settings/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN curl https://artifacts.elastic.co/GPG-KEY-elasticsearch > GPG-KEY-elasticsearch \
    && rpm --import GPG-KEY-elasticsearch \
    && rm -f GPG-KEY-elasticsearch

ENV LOGSTASH_HOME=/usr/share/logstash \
    LOGSTASH_SETTINGS_DIR=/etc/logstash \
    LOGSTASH_VOL_DIR=/var/lib/logstash \
    LOGSTASH_CONF_DIR=/var/lib/logstash/conf \
    LOGSTASH_DATA_DIR=/var/lib/logstash/data \
    LOGSTASH_PLUGIN_DIR=/var/lib/logstash/plugins \
    LOGSTASH_LOG_DIR=/var/log/logstash

VOLUME $LOGSTASH_DATA_DIR

#
# TODO: write an ENTRYPOINT SCRIPT that copies only new files on startup to
# the volume
# installed own, patched S3 plugins with configurable endpoint
COPY conf/*.conf $LOGSTASH_CONF_DIR/
#COPY plugins/logstash-input-s3-*.gem $LOGSTASH_PLUGIN_DIR/

# Install elasticsearch    
# Note: service requires no systemctl start.
# It starts with the start of systemd
RUN yum install -y logstash \
    && chown -R logstash:logstash ${LOGSTASH_PLUGIN_DIR} \
    && chown -R logstash:logstash ${LOGSTASH_CONF_DIR}

EXPOSE 9600

WORKDIR $LOGSTASH_HOME

USER logstash

# install standard plugins from web
# patched plugins without verification
RUN bin/logstash-plugin install logstash-filter-json \
    && bin/logstash-plugin install --no-verify ${LOGSTASH_PLUGIN_DIR}/logstash-input-s3-*.gem

COPY run_with_mappings.sh .

ENTRYPOINT ${LOGSTASH_HOME}/run_with_mappings.sh

#       --path.logs ${LOGSTASH_LOG_DIR} \
#       --path.plugins \
#CMD bin/logstash \
#       --http.host `hostname -I | sed 's/\([0-9.]+\)/\1/'` \
#       --path.settings "${LOGSTASH_SETTINGS_DIR}" \
#       --path.config "${LOGSTASH_CONF_DIR}" \
#       --path.data "${LOGSTASH_DATA_DIR}"
