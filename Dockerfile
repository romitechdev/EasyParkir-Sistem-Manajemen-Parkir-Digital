FROM php:8.1-apache

RUN a2enmod rewrite
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
# Install system dependencies and PHP extensions (gd with JPEG/Freetype, mysqli)
RUN apt-get update && apt-get install -y --no-install-recommends \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
	libwebp-dev \
	zlib1g-dev \
	libzip-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
	&& docker-php-ext-install -j"$(nproc)" gd mysqli zip \
	&& rm -rf /var/lib/apt/lists/*

# Copy semua file ke direktori web
COPY . /var/www/html/

# Set document root
RUN echo "DocumentRoot /var/www/html" >> /etc/apache2/apache2.conf

# Expose port 80
EXPOSE 80

CMD ["apache2-foreground"]
