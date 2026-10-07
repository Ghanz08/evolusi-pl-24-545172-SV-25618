FROM php:8.2-cli

# Pasang dependensi sistem dan ekstensi PHP yang dibutuhkan Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite \
    && rm -rf /var/lib/apt/lists/*

# Pasang Composer resmi
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# LANGKAH OPTIMASI CACHE: Salin konfigurasi dependensi terlebih dahulu
COPY composer.json composer.lock ./

# Install dependensi PHP sebelum menyalin source code aplikasi
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist

# Salin seluruh source code aplikasi
COPY . .

# Generate autoloader final setelah source code tersedia
RUN composer dump-autoload --optimize --no-dev

# Setup permission folder storage dan bootstrap cache
RUN mkdir -p database storage/framework/cache storage/framework/sessions storage/framework/views storage/logs \
    && touch database/database.sqlite \
    && chown -R www-data:www-data storage bootstrap/cache database \
    && chmod -R 775 storage bootstrap/cache database

# Inisialisasi database dan key default jika belum ada
RUN php -r "file_exists('.env') || copy('.env.example', '.env');" \
    && php artisan key:generate --force \
    && php artisan migrate --force

EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
