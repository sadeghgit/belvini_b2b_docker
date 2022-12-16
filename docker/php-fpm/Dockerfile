FROM centos:7


RUN  useradd -m -U -r -d /var/www magento \
     && chmod 750 /var/www

# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Install PHP
RUN yum -y install yum-utils

# Install PHP 8.1
#RUN yum-config-manager --enable remi-php81
#RUN yum -y install php php-{dba,bcmath,cli,common,devel,fpm,gd,intl,mbstring,mcrypt,mysqlnd,opcache,pear,pdo,process,soap,tidy,xml,zip,xsl,redis,xdebug,sodium,amqp}

# Install PHP 7.4
RUN yum --enablerepo=remi-php74 -y install php php-{dba,bcmath,cli,common,devel,fpm,gd,intl,mbstring,mcrypt,mysqlnd,opcache,pear,pdo,process,soap,tidy,xml,zip,xsl,redis,xdebug,sodium,amqp}


# Install Dependencies
RUN yum install -y \
    curl \
    git \
    gnupg \
    vim \
    wget \
    psmisc \
    unzip \
    tar \
    bash-completion \
    centos-release-scl

RUN wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
RUN yum install -y mysql80-community-release-el7-3.noarch.rpm \
    mysql-community-client

RUN mkdir -p /run/php-fpm

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=bin  && mv /usr/bin/composer.phar /usr/bin/composer && chmod +x /usr/bin/composer
RUN composer self-update --2


# Install Node, NVM, NPM and Grunt
RUN yum install -y gcc-c++ make \
    && curl -sL https://rpm.nodesource.com/setup_12.x | bash - \
    && yum install -y nodejs \
    && npm install -y -g grunt


RUN yum -y install telnet telnet-server -y
RUN yum -y install bzip2
RUN yum -y install php72-php-pecl-redis5.x86_64


# Install XDebug
#ENV PHP_XDEBUG_PORT 9003 \
#    PHP_XDEBUG_IDKEY PHPSTORM \
#    PHP_XDEBUG_REMOTE_HOST 'localhost' \
#    PHP_XDEBUG_START_WITH_REQUEST 'yes' \
#    PHP_XDEBUG_EXTENSION '/usr/lib64/php/modules/xdebug.so'

#RUN export XDEBUG_SESSION=PHPSTORM
#COPY ./.docker.env.example ./.docker.env


# Add config
ADD www.conf /etc/php-fpm.d/www.conf

WORKDIR /var/www/magento
COPY composer.* /var/www/magento

#ARG COMPOSER
#RUN if [[ -z "$COMPOSER" ]] ; composer install ;  fi

#As some includes may break the composer install process, rund the composer when the build is finished.
#RUN composer install --prefer-source --no-interaction




EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm", "-F"]







