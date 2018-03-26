FROM alpine:latest

LABEL maintainer="Skaronator"


ARG ARCH="amd64"
ARG RCLONE_VERSION="current"

ENV CRON_SCHEDULE="0 * * * *"
ENV INIT_RUN="false"

ENV RCLONE_TYPE="sync"
ENV SYNC_DESTINATION="empty"
ENV SYNC_DESTINATION_PATH="/"


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
	
VOLUME ["/config"]

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY run.sh /run.sh

RUN chmod +x /docker-entrypoint.sh


USER rclone

ENTRYPOINT ["/docker-entrypoint.sh"]