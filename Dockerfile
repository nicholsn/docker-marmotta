FROM stackbrew/ubuntu:14.04
MAINTAINER "Nolan Nichols" <http://orcid.org/0000-0003-1099-3328>

# Update and upgrade packages.
RUN apt-get update && \
    apt-get upgrade -y -o DPkg::Options::=--force-confold

# Install build dependencies.
RUN apt-get install -y --force-yes wget openjdk-7-jre-headless

# Get tomcat7
RUN wget http://apache.mirrors.lucidnetworks.net/tomcat/tomcat-7/v7.0.62/bin/apache-tomcat-7.0.62.tar.gz && \
    tar xvzf apache-tomcat-7.0.62.tar.gz && \
    mv apache-tomcat-7.0.62 /usr/local/tomcat7 && \
    rm -rf apache-tomcat-7.0.62.tar.gz /usr/local/tomcat7/webapps/*

# Get marmotta.
RUN wget http://apache.osuosl.org/marmotta/3.3.0/apache-marmotta-3.3.0-webapp.tar.gz && \
    tar xvzf apache-marmotta-3.3.0-webapp.tar.gz && \
    cp /apache-marmotta-3.3.0/marmotta.war /usr/local/tomcat7/webapps/ROOT.war && \
    rm -rf apache-marmotta-3.3.0-webapp.tar.gz /apache-marmotta-3.3.0

EXPOSE 8080

CMD /usr/local/tomcat7/bin/startup.sh && tail -f /usr/local/tomcat7/logs/catalina.out
