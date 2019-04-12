FROM alpine:3.9

RUN apk add --no-cache git openldap-dev ca-certificates gcc g++ make pcre-dev linux-headers zlib-dev openssl gettext

RUN \
  mkdir /var/log/nginx \
	&& mkdir /etc/nginx \
	&& cd ~ \
	&& git clone https://github.com/kvspb/nginx-auth-ldap.git \
	&& git clone https://github.com/nginx/nginx.git \
	&& cd ~/nginx \
	&& git checkout tags/release-1.15.11 \
	&& ./auto/configure \
		--add-module=/root/nginx-auth-ldap \
		--with-http_ssl_module \
		--with-debug \
		--conf-path=/etc/nginx/nginx.conf \
		--sbin-path=/usr/sbin/nginx \
		--pid-path=/var/log/nginx/nginx.pid \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
        --with-stream \
        --with-stream_ssl_module \
        --with-debug \
        --with-file-aio \
        --with-threads \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_v2_module \
        --with-http_auth_request_module \
	&& make install \
	&& cd .. \
	&& rm -rf nginx-auth-ldap \
	&& rm -rf nginx \
	&& wget -O /tmp/dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
	&& tar -C /usr/local/bin -xzvf /tmp/dockerize.tar.gz \
	&& rm -rf /tmp/dockerize.tar.gz \
	&& touch /_external-auth-Lw \
	&& addgroup -S nginx \
	&& adduser -S -D -H -s /bin/false -G nginx nginx \
	&& touch /var/log/nginx/access.log /var/log/nginx/error.log \
	&& chown -R nginx:nginx /etc/nginx /var/log/nginx /usr/local/nginx

EXPOSE 8080

COPY bin/run.sh /run.sh
COPY bin/nginx.conf /nginx.conf

RUN chmod +x /run.sh

USER nginx

CMD ["/run.sh"]
