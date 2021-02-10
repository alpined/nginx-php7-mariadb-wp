
# add required packages
apk add --no-cache nginx \
  php7-cli php7-phar php7-fpm php7-session \
  php7-mysqli php7-sqlite3 php7-pdo php7-pdo_mysql php7-pdo_sqlite \
  php7-xmlrpc php7-xml php7-xmlreader php7-json php7-curl \
  php7-gd php7-exif php7-zlib php7-zip php7-mcrypt \
  php7-ldap php7-pspell php7-iconv php7-opcache

# setup proper runtime
deluser nginx
adduser -D -H -u 1000 nginx

mkdir -p /var/lib/nginx /run/nginx
chown -R nginx.nginx /var/lib/nginx /run/nginx

# fix '/etc/php7/php.ini' for the lame default
#    EGPCS = (Environment, GET, POST, Cookie, Server) 
sed -i -e 's|^variables_order = .*$|variables_order = "EGPCS"|' /etc/php7/php.ini

curl -sfo /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod 755 /usr/bin/wp
