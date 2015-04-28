# Apache with PHP

Base docker image to run PHP applications on Apache (prefork) using Ubuntu Trusty. This image includes php extensions required to run Drupal 7. Database is not included.

# Usage

Basic run parameters:

    docker run \
                --name docker_apache_php \
                --publish 80:80 \
                --detach \
            hhcordero/docker-apache-php

Mount source code from host to container:

    docker run \
                --name docker_apache_php \
                --volume /path/to/app:/app \
                --publish 80:80 \
                --detach \
            hhcordero/docker-apache-php

Link with other container, assume mysql as the name of the other container:

    docker run \
                --name docker_apache_php \
                --link mysql:mysql \
                --publish 80:80 \
                --detach \
            hhcordero/docker-apache-php
