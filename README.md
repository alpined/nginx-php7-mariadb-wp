## What is this container?

All-in-one stack for nginx+php7+mariadb run-time. This **extremely tiny container** is built using secure Alpine-Linux and s6 service manager

Enjoy & $$$ benefit from it!

## How to run this container?

Simple test, run on port 8080
```
docker run --name=my-nginx-php7-mariadb-wp -d -p 8080:80 alpined/nginx-php7-mariadb-wp
```

Or specify your own webroot folder through volume mounting
```
mkdir -p htdocs
echo "<?php phpinfo(); ?>" > htdocs/index.php
```

And then run on port 8080
```
docker run --name=my-nginx-php7-mariadb-wp -d --restart=unless-stopped \
-p 8080:80 -v $(pwd)/htdocs:/www/htdocs \
alpined/nginx-php7-mariadb-wp
```
... and browse to location: http://docker_host_ip:8080/

Or run on default http port

```
docker run --name=my-nginx-php7-mariadb-wp -d --restart=unless-stopped \
-p 80:80 -v $(pwd)/htdocs:/www/htdocs \
alpined/nginx-php7-mariadb-wp
```

Or run on default http port & mount logs folder as well
```
mkdir -p logs
docker run --name=my-nginx-php7-mariadb-wp -d --restart=unless-stopped \
-p 80:80 -v $(pwd)/htdocs:/www/htdocs -v $(pwd)/logs:/www/logs \
alpined/nginx-php7-mariadb-wp
```
... and browse to location: http://docker_host_ip/

## What are the available volume mounts?

Pre-defined mounts
- /www/conf -> default server configurations
- /www/htdocs -> default web-content root
- /www/logs -> default folder for access.log, error.log, etc
- /var/lib/mysql -> data file for mysql

- /sites -> folders for virtual host htdocs [optional]

Please keep that in mind while mounting the external volume(s) that nginx & php-fpm run as user id 1000 and logs are owned by root

And set proper selinux context if needed
```
chcon -Rt svirt_sandbox_file_t $(pwd)/htdocs
```

## Recommended vhost setup

- /sites/example.com/conf/default.conf -> vhost example.com server configurations
- /sites/example.com/htdocs -> vhost example.com web-content root
- /sites/example.com/logs -> vhost example.com folder for access.log, error.log, etc

