FROM ubuntu:trusty

MAINTAINER Hector Cordero <hhcordero@gmail.com>

# Install packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install curl supervisor && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        apache2 \
        libapache2-mod-php5 && \
    apt-get -y install \
        php5 \
        php5-gd \
        php5-memcached \
        php5-mysqlnd \
        php5-xmlrpc
        
# Override default apache conf
ADD apache.conf /etc/apache2/sites-enabled/000-default.conf

# Enable apache rewrite module
RUN a2enmod rewrite

# Add image configuration and scripts
ADD start.sh /start.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# Configure /app folder
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

EXPOSE 80

CMD ["/run.sh"]
