FROM imhu/baseimage-cn-repo:latest

MAINTAINER imhu <402888327@qq.com>

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list

RUN apt-get update -y && \
    apt-get install nginx -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Apply Nginx configuration
ADD config/nginx.conf /etc/nginx/nginx.conf
COPY config/sites-available /etc/nginx/sites-available
RUN mkdir -p /etc/nginx/sites-enabled
RUN rm /etc/nginx/conf.d/default.conf

# Nginx startup script
ADD config/nginx-start.sh /tmp/nginx-start.sh
RUN chmod u=rwx /tmp/nginx-start.sh

RUN mkdir -p /data
VOLUME ["/data","/etc/nginx/sites-available"]

# PORTS
EXPOSE 80
EXPOSE 443

WORKDIR /tmp
ENTRYPOINT ["/tmp/nginx-start.sh"]
