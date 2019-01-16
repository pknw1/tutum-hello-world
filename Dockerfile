FROM alpine:2.7
MAINTAINER support@tutum.co
RUN apk --update add nginx php-fpm
RUN mkdir -p /tmp/nginx && chgrp -R 0 /tmp/nginx && chmod -R g+w /tmp/nginx \
                        && mkdir -p /usr/uwsgi_temp && chgrp -R 0 /usr/uwsgi_temp && chmod -R g+w /usr/uwsgi_temp \
                        && mkdir -p /usr/scgi_temp && chgrp -R 0 /usr/scgi_temp && chmod -R g+w /usr/scgi_temp \
                        && mkdir -p /var/log && touch /var/log/php-fpm.log \
						&& chgrp -R 0 /var/log && chmod -R g+w /var/log \
                        && echo "clear_env = no" >> /etc/php/php-fpm.conf
ADD www /www
ADD nginx.conf /etc/nginx/
EXPOSE 8080
CMD php-fpm -d variables_order="EGPCS" && exec nginx -g "daemon off;"
