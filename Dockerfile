FROM stackbrew/ubuntu:14.04
MAINTAINER "Nolan Nichols" <http://orcid.org/0000-0003-1099-3328>

RUN echo "deb http://stack.linkeddata.org/deb/ ldstack main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y -o DPkg::Options::=--force-confold
    
RUN apt-get -o DPkg::Options::=--force-confold install -y --force-yes marmotta

EXPOSE 8080
