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
COPY config/kibana.repo /etc/yum.repos.d/kibana.repo
RUN curl https://artifacts.elastic.co/GPG-KEY-elasticsearch > GPG-KEY-elasticsearch \
    && rpm --import GPG-KEY-elasticsearch \
    && rm -f GPG-KEY-elasticsearch

#
# Install elasticsearch    
# Note: service requires no systemctl start.
# It starts with the start of systemd
RUN yum install -y kibana

ENV KIBANA_HOME=/usr/share/kibana \
    KIBANA_CONF_DIR=/etc/kibana \
    KIBANA_LOG_DIR=/var/log/kibana \
    KIBANA_PID_DIR=/var/run/kibana

EXPOSE 5601

WORKDIR /usr/share/kibana

USER kibana

COPY clean_demo.sh .

#       --quiet \
#       --log-file ${KIBANA_LOG_DIR}/kibana.log \
#       --elasticsearch http://elasticsearch:${ELASTUCSEARCH_SERVICE_SERVICE_PORT}
#       --elasticsearch http://elasticsearch:9200 \
#       --elasticsearch http://$ELASTICSEARCH_SERVICE_HOST:$ELASTICSEARCH_SERVICE_PORT \
CMD bin/kibana \
       serve \
       --host=`hostname -I | sed 's/\([0-9.]+\)/\1/'` \
       --elasticsearch http://elasticsearch.elk:${ELASTICSEARCH_SERVICE_PORT} \
       --config ${KIBANA_CONF_DIR}/kibana.yml
       
