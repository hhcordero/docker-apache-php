#!/bin/bash
docker run \
            --name docker_apache_php \
            --publish 80:80 \
            --detach \
            hhcordero/docker-apache-php
