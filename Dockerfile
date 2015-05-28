FROM stackbrew/ubuntu:14.04
MAINTAINER "Nolan Nichols" <http://orcid.org/0000-0003-1099-3328>
ENV MODIFIED="May 28, 2015 2:00pm"

# Update and upgrade packages.
RUN apt-get update && \
    apt-get upgrade -y -o DPkg::Options::=--force-confold

# Install build dependencies.
RUN apt-get install -y --force-yes curl wget openjdk-7-jre-headless

# Get tomcat.
RUN wget http://apache.mirrors.lucidnetworks.net/tomcat/tomcat-7/v7.0.62/bin/apache-tomcat-7.0.62.tar.gz && \
    tar xvzf apache-tomcat-7.0.62.tar.gz && \
    mv apache-tomcat-7.0.62 /usr/local/tomcat && \
    rm -rf apache-tomcat-7.0.62.tar.gz /usr/local/tomcat/webapps/*

# Get marmotta.
RUN wget http://apache.osuosl.org/marmotta/3.3.0/apache-marmotta-3.3.0-webapp.tar.gz && \
    tar xvzf apache-marmotta-3.3.0-webapp.tar.gz && \
    cp /apache-marmotta-3.3.0/marmotta.war /usr/local/tomcat/webapps && \
    rm -rf apache-marmotta-3.3.0-webapp.tar.gz /apache-marmotta-3.3.0

# Configure marmotta access
RUN /usr/local/tomcat/bin/startup.sh && sleep 60 && \
    curl -v -X POST -H "Content-Type: application/json" -d '[":plain::pass123"]' http://localhost:8080/marmotta/config/data/user.admin.pwhash && \
    curl -X POST -H "Content-Type: application/json" -d '["standard"]' http://localhost:8080/marmotta/config/data/security.profile
RUN /usr/local/tomcat/bin/shutdown.sh

EXPOSE 8080

CMD /usr/local/tomcat/bin/startup.sh && tail -f /usr/local/tomcat/logs/catalina.out
