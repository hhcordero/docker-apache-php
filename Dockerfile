FROM ubuntu:trusty

MAINTAINER Hector Cordero <hhcordero@gmail.com>

# Update/upgrade packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Install required packages - do not remove
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor

# Install application and dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
        apache2 \
        curl && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        libapache2-mod-php5 \
        php-pear \
        php5 \
        php5-dev \
        php5-gd \
        php5-memcached \
        php5-mysqlnd \
        php5-xmlrpc

# Install remaining pecl package dependencies, use php5enmod to enable php module
RUN pecl channel-update pecl.php.net && \
    echo -e "; configuration for php uploadprogress module\n; priority=20\nextension=uploadprogress.so" > /etc/php5/mods-available/uploadprogress.ini && \
    pear config-set php_ini /etc/php5/mods-available/uploadprogress.ini && \
    pecl install uploadprogress && \
    php5enmod uploadprogress
        
# Override default apache conf
ADD /conf/apache.conf /etc/apache2/sites-enabled/000-default.conf

# Enable apache module
RUN a2enmod rewrite

# Add image configuration and scripts
ADD /scripts/start.sh /start.sh
ADD /scripts/run.sh /run.sh
ADD /conf/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
RUN chmod 755 /*.sh

# Create /app directory and create symlink in /var/www/html
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

EXPOSE 80

CMD ["/run.sh"]
