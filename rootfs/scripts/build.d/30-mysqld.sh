
apk add --no-cache mariadb-common libaio ncurses-libs libstdc++ pwgen pcre xz-libs

apk add --no-cache mariadb mariadb-client

tar cf /tmp/mariadb-micro.tar \
/usr/bin/mysqld /usr/bin/mariadbd \
/usr/bin/mysql_install_db /usr/bin/mariadb-install-db \
/usr/bin/my_print_defaults \
/usr/share/mariadb/ \
/usr/lib/mariadb/ \
/usr/bin/mysql /usr/bin/mariadb \
/usr/bin/mysqldump /usr/bin/mariadb-dump \
/etc/mysql /etc/my.cnf*

apk del mariadb mariadb-client

tar xf /tmp/mariadb-micro.tar
