# debezium-server-performance
Test Debezium Server Performance

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

    # Start docker containers
    docker compose -f docker-compose.yaml --env-file settings.env up -d


