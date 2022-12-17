FROM ubuntu:jammy

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -y && \
apt install -y php8.1 php8.1-xml php8.1-gd php8.1-ldap php8.1-zip php8.1-imap php8.1-mbstring php8.1-pgsql

ADD apache_default /etc/apache2/sites-available/limesurvey.conf

RUN mkdir -p /var/www/html/limesurvey

COPY . /var/www/html/limesurvey

RUN chmod -R 755 /var/www/html/limesurvey \
    && chown -R www-data:www-data /var/www/html/limesurvey

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY start.sh /start.sh

EXPOSE 80

ENTRYPOINT ["bash","/start.sh"] 