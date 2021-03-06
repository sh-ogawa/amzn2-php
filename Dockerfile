# Dockerfile for PHP72

FROM amazonlinux:2.0.20190212
LABEL author=sh-ogawa version=1.0

RUN amazon-linux-extras install php7.2 \
&& yum install -y php php-bcmath php-cli php-common php-dba php-devel php-fpm php-gd php-json php-mbstring php-mysqlnd php-odbc php-pdo php-pear php-process php-pspell php-soap php-xml php-xmlrpc php-pecl-zip php-xdebug \
&& yum install -y curl libxml2 libxml2-devel \
&& yum install -y httpd \
&& yum install -y gcc \
&& yum install -y make \
&& yum install -y zip \
&& pecl install xdebug 

RUN { \
    echo '<FilesMatch \.php$>'; \
    echo '  SetHandler application/x-httpd-php'; \
    echo '</FilesMatch>'; \
    echo; \
    echo 'DirectoryIndex disabled'; \
    echo 'DirectoryIndex index.php index.html'; \
    echo; \
    echo '<Directory /var/www/html/public>'; \
    echo '  Options -Indexes'; \
    echo '  AllowOverride All'; \
    echo '  EnableMMAP Off'; \
    echo '  EnableSendfile Off'; \
    echo '</Directory>'; \
} | tee "/etc/httpd/conf.d/docker-php.conf"

WORKDIR /var/www/html

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
