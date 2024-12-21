# Docker image med redhat ubi 9, PHP installerat samt wordpress 6.7.1
FROM docker.io/redhat/ubi9:latest

# installayion php
ENV WORDPRESS_VERSION=6.7.1
# PHP installation
RUN yum install -y \
        httpd \
        php \
        php-mysqlnd \
        php-json \
        php-curl \
        php-gd \
        php-mbstring \
        php-xml \
        php-opcache \
        wget \
        tar \
        unzip \
    && yum clean all


# Nerladdning, uppackning och installation av WordPress
RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && unzip /tmp/wordpress.zip -d /var/www/html && rm /tmp/wordpress.zip

# Rättigheter för WordPress
RUN chown -R apache:apache /var/www/html \
    && chmod -R 755 /var/www/html

# Katalogen för wordpress
WORKDIR /var/www/html/wordpress/


#Ändring konfiguration för APACHE till port8080 med sed 
RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf



# öppnar port 8080 i poden
EXPOSE 8080

# Startar php med port 8080 från /wordpress
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html/wordpress/"]
#CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
