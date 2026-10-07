# ==========================================
# STAGE 1: BUILDER (Full Toolchain & Composer)
# ==========================================
FROM php:8.2-cli AS builder

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2.8.9 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist

COPY . .
RUN composer dump-autoload --optimize --no-dev

# ==========================================
# STAGE 2: RUNNER (Alpine Minimalist Runtime)
# ==========================================
FROM php:8.2-cli-alpine

# Pasang curl untuk HEALTHCHECK dan library sqlite3 runtime
RUN apk add --no-cache curl sqlite-libs

WORKDIR /var/www/html

# Salin seluruh artefak aplikasi & vendor yang sudah siap dari builder
COPY --from=builder /app /var/www/html

# Setup direktori dan izin akses untuk user non-root www-data (UID 82 di Alpine)
RUN mkdir -p database storage/framework/cache storage/framework/sessions storage/framework/views storage/logs \
    && touch database/database.sqlite \
    && php -r "file_exists('.env') || copy('.env.example', '.env');" \
    && php artisan key:generate --force \
    && php artisan migrate --force \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 storage bootstrap/cache database

# SYARAT KEAMANAN: Berjalan sebagai user non-root
USER www-data

# SYARAT HEALTHCHECK: Cek status kesehatan container secara berkala
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://127.0.0.1:8000/api/tugas || exit 1

EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
