FROM registry.access.redhat.com/ubi8/openjdk-11

LABEL maintainer="Debezium Community"

#
# Set the version, home directory, and MD5 hash.
#
ENV DEBEZIUM_VERSION=1.7.2.Final \
    SERVER_HOME=/debezium \
    MAVEN_REPO_CENTRAL="https://repo1.maven.org/maven2"
ENV SERVER_URL_PATH=io/debezium/debezium-server-dist/$DEBEZIUM_VERSION/debezium-server-dist-$DEBEZIUM_VERSION.tar.gz \
    SERVER_MD5=d5964cd09ba86141d48366e30def5f54

#
# Create a directory for Debezium Server
#
USER root
RUN microdnf -y install gzip && \
    microdnf clean all && \
    mkdir $SERVER_HOME && \
    chmod 755 $SERVER_HOME

#
# Change ownership and switch user
#
RUN chown -R jboss $SERVER_HOME && \
    chgrp -R jboss $SERVER_HOME
USER jboss

RUN mkdir $SERVER_HOME/conf && \
    mkdir $SERVER_HOME/data

#
# Download and install Debezium Server
#
COPY debezium-server-dist-1.7.0-SNAPSHOT.tar.gz /tmp/debezium.tar.gz 

#
# Verify the contents and then install ...
#
RUN tar xzf /tmp/debezium.tar.gz -C $SERVER_HOME --strip-components 1

#
# Allow random UID to use Debezium Server
#
RUN chmod -R g+w,o+w $SERVER_HOME

# Set the working directory to the Debezium Server home directory
WORKDIR $SERVER_HOME

#
# Expose the ports and set up volumes for the data, transaction log, and configuration
#
EXPOSE 8080
VOLUME ["/debezium/conf","/debezium/data"]

CMD ["/debezium/run.sh"]
