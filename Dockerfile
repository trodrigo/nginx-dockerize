FROM php:7.3.6-fpm-alpine3.9
# instala bash e client do mysql
RUN apk add bash mysql-client --no-cache openssl nodejs npm
# habilita/instala extensoes do pdo
RUN docker-php-ext-install pdo pdo_mysql


# instala dockerize para gerenciar dependencia entre containers
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# seta workdir e remove conteudo default do fpm
WORKDIR /var/www
RUN rm -rf /var/www/html

# instala composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# copia laravel para dentro do container
#COPY . /var/www
#RUN composer install \
# && cp .env.example .env \
# && php artisan key:generate \
# && php artisan migrate

# cria link simbolico do public/html
RUN ln -s public html

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
