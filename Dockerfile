# syntax=docker/dockerfile:1

#
# See https://docs.docker.com/language/golang/build-images/ for more information
# on how this Dockerfile was constructed.
#

#
# The base build container
#
FROM golang:1.18-buster AS build-image

WORKDIR /

#
# Add build files to the build container and pull
# down dependencies.
#
COPY Makefile ./
COPY go.mod ./
# You'll need this when there are actually dependencies.
# COPY go.sum ./
RUN go mod download

#
# Copy the source into the build container.
#
COPY *.go ./

#
# Buld the application.
#
RUN make

#
# Construct the runtime container.
#
FROM scratch

WORKDIR /

#
# Copy the application itself from the build
# container to the runtime container.
#
COPY --from=build-image /docker-go docker-go

#
# Runs the application.
#
ENTRYPOINT ["/docker-go"]