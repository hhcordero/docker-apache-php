FROM ubuntu:trusty

MAINTAINER Hector Cordero <hhcordero@gmail.com>

# Update repository, install application and dependencies then clean-up after
RUN set -x \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
        apache2 \
        curl \
        libapache2-mod-php5 \
        php-pear \
        php5 \
        php5-dev \
        php5-gd \
        php5-memcached \
        php5-mysqlnd \
        php5-xmlrpc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install remaining pecl package dependencies, use php5enmod to enable php module
RUN pecl channel-update pecl.php.net \
    && echo -e "; configuration for php uploadprogress module\n; priority=20\nextension=uploadprogress.so" > /etc/php5/mods-available/uploadprogress.ini \
    && pear config-set php_ini /etc/php5/mods-available/uploadprogress.ini \
    && pecl install uploadprogress \
    && php5enmod uploadprogress
        
# Copy default apache vhost conf
COPY /conf/default-vhost.conf /etc/apache2/sites-available/000-default.conf

# Enable apache module
RUN a2enmod rewrite

# Copy container script
COPY /scripts/apache-foreground /usr/local/bin/

RUN chmod +x /usr/local/bin/apache-foreground

# Create /app directory and create symlink in /var/www/html
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

VOLUME /app

EXPOSE 80 443

CMD ["apache-foreground"]
