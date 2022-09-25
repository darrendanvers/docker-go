#! /bin/sh

## Builds and tags the container
docker build . -t docker-go:1.0

## Runs the image and removes the container once complete.
docker run --rm docker-go:1.0