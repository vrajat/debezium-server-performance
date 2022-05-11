# debezium-server-performance
# Setup the Dev Server

    #install docker
    ./setup.sh

    # build debezium server. Requires debezium-server tar.gz
    docker build -t yugabytedb/debezium-server:1.7.0-yb-1 .

    # Install Yugabyte clients.
    cd $HOME
    wget https://downloads.yugabyte.com/releases/2.13.1.0/yugabyte-2.13.1.0-b112-linux-x86_64.tar.gz
    tar -zxvf yugabyte-2.13.1.0-b112-linux-x86_64.tar.gz
    cd ~/yugabyte-2.13.1.0/bin/
    ./post_install.sh

    # Setup maven and java 11
    sudo yum install -y maven java-11-openjdk-devel java-11-openjdk
    sudo alternatives --config java # Choose Java 11
    echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.15.0.9-2.el8_5.x86_64/" >> $HOME/.bashrc
    ## Ensure Java 11 is chosen
    source $HOME/.bashrc
    java -version
    mvn -version


# Setup Yugabyte Cluster

    ./connector_setup.sh

# Create a settings file


#  Start all services in docker

    # Start Debezium server
    docker compose -f docker-compose-dbz.yaml --env-file settings.env up -d

    # Start docker containers
    docker compose -f docker-compose.yaml --env-file settings.env up -d

# Setup Kafka Connect

    # Setup consumers
    ./cdc_setup.sh

# Setup and run workloads

    ./compile_apps.sh
    ./run_workloads.sh
