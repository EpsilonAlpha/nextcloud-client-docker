#!/bin/bash
time docker build \
        --build-arg VCS_REF=$(git rev-parse --short HEAD) \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        -t stoutyhk/nextcloud-client . | tee build.log
docker images stoutyhk/nextcloud-client