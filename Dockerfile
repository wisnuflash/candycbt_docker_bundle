FROM porchn/php7-apache
# Menyalin file konfigurasi Apache
COPY config/apache/default.conf /etc/apache2/sites-available/default.conf

# Mengaktifkan konfigurasi Apache
RUN a2ensite default.conf && a2dissite 000-default.conf
# Menetapkan direktori kerja
WORKDIR /var/www/html
# Menyalin seluruh aplikasi
# COPY ./app /var/www/html

# Mengatur izin file
RUN chown -R www-data:www-data /var/www/html

# Mengekspos port 80 untuk Apache
EXPOSE 80

# Menjalankan Apache saat container dimulai
CMD ["apache2-foreground"]
