# Apache with PHP

Base docker image to run PHP applications on Apache (prefork) using Ubuntu Trusty. This image includes php extensions required to run Drupal 7. Database is not included.

## Usage
            docker run \
                        --name docker_apache_php \
                        --publish 80:80 \
                        --volume /path/to/app:/app \
                        --detach \
                    hhcordero/docker-apache-php
