FROM alpine:latest
MAINTAINER Skaronator <Skaro@Skaronator.com>


ARG ARCH="amd64"
ARG RCLONE_VERSION="current"

ENV CRON_SCHEDULE="0 * * * *"
ENV SYNC_DESTINATION=""
ENV SYNC_DESTINATION_PATH=""

ENV RCLONE_TYPE="sync"
ENV INIT_RUN="false"



RUN \
  apk update && \
  apk add --no-cache ca-certificates fuse wget

RUN \
  cd /tmp && \
  wget -q http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip && \
  unzip /tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip && \
  mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin

RUN \
  rm -rf /tmp/* && \
  rm -rf /var/cache/apk/*

# create user and group
RUN \
  addgroup rclone && \
  adduser -h /config -s /bin/ash -G rclone -D rclone
	
USER rclone

VOLUME ["/config"]

#ENTRYPOINT ["/usr/bin/rclone"]

CMD ["/entry.sh"]