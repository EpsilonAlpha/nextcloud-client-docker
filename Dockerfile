FROM alpine:3.21.0
LABEL maintainer="stoutyhk" version="0.1" description="nextcloud sync client"
LABEL based-on="https://github.com/juanitomint/nextcloud-client-docker"
LABEL repo="https://github.com/jamesstout/nextcloud-client-docker"

ARG VCS_REF
ARG BUILD_DATE

LABEL vcs-ref=$VCS_REF
LABEL build-date=$BUILD_DATE

ARG USER=ncsync
ARG GROUP=users
ARG USER_UID=1026
ARG USER_GID=100

ENV USER=$USER \
    GROUP=$GROUP \
    USER_UID=$USER_UID \
    USER_GID=$USER_GID \
    NC_USER=username \
    NC_PASS=password \
    NC_INTERVAL=500 \
    NC_URL="" \
    NC_TRUST_CERT=false \
    NC_SILENT=false \
    NC_EXIT=false   \
    NC_HIDDEN=false \
    NC_MAX_SYNC_RETRIES=3


# create user
RUN adduser -G $GROUP -D -u $USER_UID $USER

# update repositories and install nextcloud-client
RUN apk update && apk add nextcloud-client && rm -rf /etc/apk/cache

# add run script
ADD run.sh /usr/bin/run.sh

VOLUME [ "/media/nextcloud" ]
VOLUME [ "/config" ]

CMD /usr/bin/run.sh
