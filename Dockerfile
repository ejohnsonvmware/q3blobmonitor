FROM ubuntu:latest
MAINTAINER Erik Johnson "ejohnson@vmware.com"
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential curl
COPY ./blobmonitor.sh /blobmonitor.sh
CMD ["/blobmonitor.sh"]
