#
# this is the base image for different elk componente/services
# Baseimage: CentOS7 with systemd enabled
FROM 160.44.200.121:443/otc-eu-de-00000000001000023731/java8-centos7-base:1.8

LABEL maintainer="Bernd Rederlechner <bernd.rederlechner@t-systems.com>" \
      tsystems.project="CCE Devops Tutorial" \
      tsystems.application="ELK OBS general purpose stack"

#
# Install repo
# TODO: heck key checksum:
# && gpg --recv-keys GPG-KEY-elasticsearch \
WORKDIR /tmp
COPY config/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN curl https://artifacts.elastic.co/GPG-KEY-elasticsearch > GPG-KEY-elasticsearch \
    && rpm --import GPG-KEY-elasticsearch \
    && rm -f GPG-KEY-elasticsearch

#
# Install elasticsearch    
# Note: service requires no systemctl start.
# It starts with the start of systemd
RUN yum install -y nslookup elasticsearch

ENV ELASTIC_HOME=/usr/share/elasticsearch \
    ELASTIC_CONF_DIR=/etc/elasticsearch \
    ELASTIC_DATA_DIR=/var/lib/elasticsearch \
    ELASTIC_LOG_DIR=/var/log/elasticsearch \
    ELASTIC_PID_DIR=/var/run/elasticsearch \ 
    ES_PATH_CONF=${ELASTIC_CONF_DIR}    

EXPOSE 9200 9300

WORKDIR ${ELASTIC_HOME}

USER elasticsearch

VOLUME ${ELASTIC_DATA_DIR}

COPY config/elasticsearch.yml $ELASTIC_CONF_DIR/
COPY config/log4j2.properties $ELASTIC_CONF_DIR/

#       --quiet \
#       -Epath.home=${ELASTIC_HOME} \
#       -Epath.conf=${ELASTIC_CONF_DIR} \
CMD bin/elasticsearch \
       -p ${ELASTIC_PID_DIR}/elasticsearch.pid \
       -Enetwork.host=0.0.0.0 \
       --verbose

