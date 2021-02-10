#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
    echo "[INFO] MySQL directory already present, skipping creation"
else
    echo "[INFO] MySQL data directory not found, creating initial DBs"

    chown -R mysql:mysql /var/lib/mysql

    mysql_install_db --user=mysql --datadir='/var/lib/mysql' --force > /dev/null

    if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
        MYSQL_ROOT_PASSWORD=$(pwgen 16 1)
        echo "[INFO] MySQL root Password: $MYSQL_ROOT_PASSWORD"
    fi

cat <<- EOF > ~/.my.cnf
    [client]
    password="$MYSQL_ROOT_PASSWORD"
EOF

    MYSQL_DATABASE=${MYSQL_DATABASE:-""}
    MYSQL_USER=${MYSQL_USER:-""}
    MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        return 1
    fi

cat <<- EOF > $tfile
        USE mysql;
        DELETE FROM user WHERE user = 'root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
        FLUSH PRIVILEGES;
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'::1' WITH GRANT OPTION;
        UPDATE user SET password=PASSWORD("$MYSQL_ROOT_PASSWORD") WHERE user='root';
        FLUSH PRIVILEGES;
        DROP DATABASE test;
EOF

    if [ "$MYSQL_DATABASE" != "" ]; then
        echo "[INFO] Creating database: $MYSQL_DATABASE"
        echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

        if [ "$MYSQL_USER" != "" ]; then
        echo "[INFO] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
        echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        fi
    fi

    /usr/bin/mysqld --user=mysql --datadir='/var/lib/mysql' --bootstrap --verbose=0 < $tfile
    rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql --datadir='/var/lib/mysql' --skip_networking=0 --console