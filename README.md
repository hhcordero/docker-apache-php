# Docker Apache (prefork) with PHP (with required php extensions for Drupal)

Base docker image to run PHP applications on Apache (prefork)

## Usage

docker run \
            --name docker_apache_php \
            --publish 80:80 \
            --volume /path/to/app:/app \
            --detach \
        hhcordero/docker-apache-php
