FROM rawmind/rancher-jvm8:0.0.2
MAINTAINER Raul Sanchez <rawmind@gmail.com>

# Set environment
ENV GOCD_REPO=https://download.go.cd/gocd/ \
  GOCD_RELEASE=go-server-16.1.0 \
  GOCD_REVISION=2855 \
  GOCD_HOME=/opt/go-server \
  PATH=$GOCD_HOME:$PATH
ENV GOCD_RELEASE_ARCHIVE=${GOCD_RELEASE}-${GOCD_REVISION}.zip \
  SERVER_WORK_DIR=${GOCD_HOME}/work

# Install and configure gocd
RUN apk add --update git apache2-utils && rm -rf /var/cache/apk/* \
  && mkdir /var/log/go-server /var/run/go-server \
  && cd /opt && curl -sSL ${GOCD_REPO}/${GOCD_RELEASE_ARCHIVE} -O && unzip ${GOCD_RELEASE_ARCHIVE} && rm ${GOCD_RELEASE_ARCHIVE} \
  && ln -s /opt/${GOCD_RELEASE} ${GOCD_HOME} \
  && chmod 774 ${GOCD_HOME}/*.sh \
  && mkdir -p ${GOCD_HOME}/work/users

WORKDIR ${GOCD_HOME}

ENTRYPOINT ["/opt/go-server/server.sh"]
