FROM ikaruswill/firefly-iii-base-fpm-alpine:latest

# See also: https://github.com/JC5/firefly-iii-base-image

ENV FIREFLY_PATH=/var/www/firefly-iii COMPOSER_ALLOW_SUPERUSER=1
LABEL version="1.5" maintainer="thegrumpydictator@gmail.com"

# Create volumes
VOLUME $FIREFLY_PATH/storage/export $FIREFLY_PATH/storage/upload

# Copy in Firefly III source
WORKDIR $FIREFLY_PATH
ADD . $FIREFLY_PATH

# Ensure correct app directory permission, then `composer install`
RUN chown -R www-data:www-data /var/www && \
    chmod -R 775 $FIREFLY_PATH/storage && \
    composer install --prefer-dist --no-dev --no-scripts --no-suggest

# Expose port 80
EXPOSE 80

# Run entrypoint thing
ENTRYPOINT [".deploy/docker/entrypoint.sh"]
