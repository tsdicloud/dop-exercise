FROM centos:7

LABEL maintainer="Bernd Rederlechner <bernd.rederlechner@t-systems.com>" \
      tsystems.project="CCE Devops Tutorial" \
      tsystems.application="ELK OBS general purpose stack"

RUN yum update -y && yum install -y curl sed egrep

ENV JAVA_VERSION=jre8
#ENV JAVA_FLAVOR=jdk8
#ENV JAVA_FLAVOR=server-jre8

WORKDIR /tmp
RUN O_URL1="http://www.oracle.com/technetwork/java/javase/downloads/index.html" \
    O_URL2=`curl -s ${O_URL1} | egrep -o "\/technetwork\/java/\javase\/downloads\/${JAVA_VERSION}-downloads-[0-9]+\.html" | head -n 1`; \
    O_PKGINFO=`curl -s http://www.oracle.com/${O_URL2} |egrep -o "downloads\[.*\]\['files'\]\['.*-linux-x64.rpm'\]\s+=\s+{.*};"` \
    O_PKGURL=`echo ${O_PKGINFO} |  sed 's/.*"filepath"\s*:\s*"\([^"]*\)".*;/\1/'`\
    O_PKGHASH=`echo ${O_PKGINFO} | sed 's/.*"SHA256"\s*:\s*"\([^"]*\)".*;/\1/'` \
    O_PKGNAME=`basename ${O_PKGURL}`; \
    curl -s -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k ${O_PKGURL} \
    && echo "${O_PKGHASH} ${O_PKGNAME}" | sha256sum --check --status \
    && yum install -y ${O_PKGNAME} \
    && rm -f ${O_PKGNAME}

ENV JAVA_HOME="/usr/java/default"
ENV PATH=${JAVA_HOME}/bin:${PATH}

WORKDIR ${JAVA_HOME}
