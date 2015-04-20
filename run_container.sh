#!/bin/bash
docker run \
            --name docker_apache_php \
            --publish 80:80 \
            --volume ~/repo/poc/app:/app \
            --detach \
        54.251.116.129:80/docker-apache-php
