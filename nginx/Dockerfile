FROM jwilder/nginx-proxy
MAINTAINER Cesco Ferraro <francescoaferraro@gmail.com>
ADD ./ /etc/nginx/certs
RUN { \
      echo 'underscores_in_headers on;'; \
    } > /etc/nginx/conf.d/my_proxy.conf
EXPOSE 443
EXPOSE 80
