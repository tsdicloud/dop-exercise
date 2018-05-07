#
# this is the base image for different elk componente/services
# Baseimage: CentOS7 with systemd enabled
FROM 160.44.200.121:443/otc-eu-de-00000000001000023731/java8-centos7-base:1.8

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
RUN yum install -y logstash
#    && chown -R logstash:logstash ${LOGSTASH_PLUGIN_DIR} \
#    && chown -R logstash:logstash ${LOGSTASH_CONF_DIR}

EXPOSE 9600



WORKDIR /usr/share/logstash

ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/logstash/bin:$PATH

# Provide a minimal configuration, so that simple invocations will provide
# a good experience.
ADD config/pipelines.yml config/pipelines.yml
ADD config/logstash-oss.yml config/logstash.yml
ADD config/log4j2.properties config/
ADD pipeline/*.conf pipeline/
RUN chown --recursive logstash:logstash config/ pipeline/

# Ensure Logstash gets a UTF-8 locale by default.
ENV LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8'

USER logstash

COPY run_with_mappings.sh .

# install standard plugins from web
# patched plugins without verification
RUN bin/logstash-plugin install logstash-filter-json logstash-input-s3

ENTRYPOINT ${LOGSTASH_HOME}/run_with_mappings.sh
