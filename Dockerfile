FROM php:8.1-fpm

RUN apt-get update
RUN apt-get install -y \
    autoconf \ 
	pkg-config \
	libssl-dev \
	libicu-dev \ 
	git \
	zip \
	unzip \
	vim \
	sudo \
	wget \
	zlib1g-dev \
	libzip-dev \
	libpng-dev \
	libpq-dev \
	xfonts-75dpi \
	xfonts-base \
	gvfs \
	colord \
	glew-utils \
	libvisual-0.4-plugins \
	gstreamer1.0-tools \
	opus-tools \
	qt5-image-formats-plugins \
	qtwayland5 \
	qt5-qmltooling-plugins \
	librsvg2-bin \
	lm-sensors \
	cron

RUN pecl install mongodb-1.12.0
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini
RUN echo "" >> /usr/local/etc/php/conf.d/custom.ini

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN tar xvJf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN sudo cp wkhtmltox/bin/wkhtmlto* /usr/bin/

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install ctype
RUN docker-php-ext-install fileinfo
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install opcache

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.bashrc

WORKDIR /usr/www
RUN chown -R www-data:www-data /usr/www

RUN mkdir /var/www/.ssh
RUN chown -R www-data:www-data /var/www/.ssh

ADD start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
