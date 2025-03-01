# Tahap 1: Mengambil Composer dari image yang sesuai dengan PHP 7.4
FROM composer:2.8.4 AS composer

# Tahap 2: Menggunakan image PHP 7.4 dengan Apache
FROM php:7.4-apache

# Menginstal dependensi yang diperlukan
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    git \
    curl \
    nano \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite headers

# Menyalin file konfigurasi Apache
COPY config/apache/default.conf /etc/apache2/sites-available/default.conf

# Mengaktifkan konfigurasi Apache
RUN a2ensite default.conf && a2dissite 000-default.conf

# Menyalin Composer dari tahap sebelumnya
COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Menetapkan direktori kerja
WORKDIR /var/www/html

# Menyalin file composer.json dan composer.lock
COPY ./app/composer.json ./app/composer.lock ./

# Menginstal dependensi PHP
# RUN composer install --no-interaction --no-plugins --no-scripts --no-dev --prefer-dist

# Menyalin seluruh aplikasi
COPY ./app /var/www/html

# Mengatur izin file
RUN chown -R www-data:www-data /var/www/html

# Mengekspos port 80 untuk Apache
EXPOSE 80

# Menjalankan Apache saat container dimulai
CMD ["apache2-foreground"]
