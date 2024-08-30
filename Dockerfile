FROM docker.io/library/composer:latest as vendor

WORKDIR /tmp/

COPY composer.json composer.json
COPY composer.lock composer.lock

RUN composer install \
	--ignore-platform-reqs \
	--no-interaction \
	--no-plugins \
	--no-scripts \
	--prefer-dist

FROM docker.io/serversideup/php:8.3-fpm-nginx

COPY . /var/www/html
COPY --from=vendor /tmp/vendor/ /var/www/html/public/vendor/
