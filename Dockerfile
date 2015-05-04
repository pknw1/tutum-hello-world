FROM alpine
MAINTAINER support@tutum.co
RUN apk --update add nginx php-fpm
RUN mkdir -p /tmp/nginx && echo "clear_env = no" >> /etc/php/php-fpm.conf
ADD www /www
ADD nginx.conf /etc/nginx/
CMD php-fpm -d variables_order="EGPCS" && nginx -g "daemon off;"