#!/bin/sh

docker buildx build -t matthis974/multicast-relay:latest --push --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 .
# docker buildx build -t scyto/multicast-relay:latest --push --platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6 .
