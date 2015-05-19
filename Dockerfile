FROM stackbrew/ubuntu:14.04
MAINTAINER "Nolan Nichols" <http://orcid.org/0000-0003-1099-3328>

# Update and upgrade packages.
RUN apt-get update && \
    apt-get upgrade -y -o DPkg::Options::=--force-confold

# Install build dependencies.
RUN apt-get install -y --force-yes maven git openjdk-7-jdk

# Clone and build marmotta.
RUN git clone https://git-wip-us.apache.org/repos/asf/marmotta.git marmotta && \
    cd marmotta && \
    mvn clean install -DskipTests=true

# Prepare to launch app.
RUN cd launchers/marmotta-webapp

EXPOSE 8080

CMD mvn tomcat7:run
