###############################################################################
# Name:         Dockerfile
# Author:       Daniel Middleton <daniel-middleton.com>
# Description:  Dockerfile used to build dannydirect/tinyproxy
# Usage:        docker build -t dannydirect/tinyproxy:latest .
###############################################################################

FROM ubuntu:latest

MAINTAINER Daniel Middleton <daniel-middleton.com>

ADD run.sh /opt/docker-tinyproxy/run.sh

RUN apt-get update && apt-get -y upgrade && apt-get -y install tinyproxy

ENTRYPOINT ["/opt/docker-tinyproxy/run.sh"]
