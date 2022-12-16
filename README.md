![Magento 2](https://cdn.rawgit.com/rafaelstz/magento2-snippets-visualstudio/master/images/icon.png)

#  Magento 2 Docker to Development

### CentOS 7 + Nginx + Redis + PHP-FPM 7.4 +  MySQL 8 + PHPMyAdmin + XDebug + Node + Grunt + Mailhog + RabbitMQ + Elasticsearch 7.6

The docker stack is composed of the following containers
- nginx
- php-fpm
- phpmyadmin
- redis
- mysql
- mailhog
- elasticsearch

#### Container nginx
Builds from the nginx folder. <br>
Mounts the folder magento2 from the project main folder into the container volume `/data/magento2/httpdocs`.<br>
Opens local port: `8000`

#### Container php-fpm
Builds from the php-fpm folder.<br>
Mounts the folder magento2 from the project main folder into the container volume `/data/magento2/httpdocs`.<br>
This container includes all dependencies for magento 2 (Also contain composer, node, grunt, code sniffer and xDebug).<br>
Opens local port: `9000`

### Container phpmyadmin:
Creates a fully working phpmyadmin container.<br>
Opens up port: `8080`
        
    To access phpmyadmin http://localhost:8080 or http://ip_of_the_docker_server:8080

### Container redis:
Starts a redis container.<br>
Opens up port: `6379`

### Container mysql 8:
Please change or set the mysql environment variables
    
    MYSQL_DATABASE: 'xxxx'
    MYSQL_ROOT_PASSWORD: 'xxxx'
    MYSQL_USER: 'xxxx'
    MYSQL_PASSWORD: 'xxxx'
    MYSQL_ALLOW_EMPTY_PASSWORD: 'xxxxx'

Opens up port: `3306`

Note: On your host, port 3306 might already be in use. So before running docker-compose.yml, under the docker-compose.yml's mysql section change the host's port number to something other than 3306, select any as long as that port is not already being used locally on your machine.

### Container mailhog:
Starts a mailhog container.<br>
Opens up port: `1025` and `8025`

### Container rabbitmq:
Starts a rabbitmq container.<br>
Opens up port: `5672`

### Container elasticsearch 7.6.0:
Starts a elasticsearch container.<br>
Opens up port: `9200` and `9300`

## Setup
To start/build the stack.

Use - `docker-compose up` or `docker-compose up -d` to run the container on detached mode. 

Compose will take some time to execute.

After the build has finished you can press the ctrl+c and docker-compose stop all containers.

## Installing Magento
log into the php-fpm-mg2 and run:

    php bin/magento cache:clean
    php bin/magento cache:flush
    php bin/magento setup:upgrade
    php bin/magento setup:di:compile


To access your web server's command line, run the following commands on your CLI.

    docker exec -it <web-servers-container-name> bash

## Setting up Magento

To access the magento setup wizard, go to the following url: http://localhost:8000 or http://ip_of_the_docker_server:8000

Proceed with the installation using the magento setup wizard.

## Feature Updates
v1.0.0 - Stable release


## Important Magento commands
    php bin/magento indexer:reindex
    bin/magento indexer:reindex catalogsearch_fulltext
    
    php bin/magento cache:clean
    php bin/magento cache:flush
    php bin/magento setup:upgrade
    php bin/magento setup:di:compile
    
    php bin/magento deploy:mode:set production
    
    php bin/magento module:disable Magento_TwoFactorAuth
    php bin/magento setup:static-content:deploy -f
    php bin/magento cache:clean config
    php bin/magento sampledata:deploy
    php bin/magento info:adminuri
    php bin/magento app:config:import
    
    INSERT INTO core_config_data (path, value)
    VALUES ('dev/static/sign', 0)
    ON DUPLICATE KEY UPDATE value = 0;
    
    docker cp <container>:<src-path> <local-dest-path>
    apk add curl
    
    rm -Rf var/cache/*
    rm -Rf generated/* (or rm -Rf var/generation/* depending on your Magento version)
    rm -rf var/di/* var/generation/* var/cache/* var/page_cache/* var/view_preprocessed/* var/composer_home/cache/*
    
    
    find var generated vendor pub/static pub/media app/etc -type f -exec chmod u+w {} +
    find var generated vendor pub/static pub/media app/etc -type d -exec chmod u+w {} +
    chmod u+x bin/magento


    Redis-mg2 172.19.0.11
    vsf-pwa-mg2 172.19.0.13
    vsf-api-mg2 172.19.0.10
    es01 172.19.0.14


