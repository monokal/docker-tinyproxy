# Docker Tinyproxy by Daniel Middleton <daniel-middleton.com>

FROM phusion/baseimage:latest

MAINTAINER Daniel Middleton <daniel-middleton.com>

ADD run.sh /opt/docker-tinyproxy/run.sh

RUN apt-get update && apt-get -y upgrade && apt-get -y install tinyproxy

ENTRYPOINT ["/opt/docker-tinyproxy/run.sh"]
