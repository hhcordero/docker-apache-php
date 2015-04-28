#!/bin/bash
docker run \
            --name docker_apache_php \
            --link docker_mysql_drupal:mysql \
            --publish 80:80 \
            --volume ~/repo/poc/app:/app \
            --detach \
        54.251.116.129:5050/docker-apache-php
