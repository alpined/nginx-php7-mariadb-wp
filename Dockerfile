FROM alpine:latest

# root filesystem
COPY rootfs /

# container builder, let sh run it
RUN /bin/sh /scripts/build.sh

# volumes
VOLUME ["/www/conf", "/www/htdocs", "/www/logs", "/sites", "/var/lib/mysql"]

# port
EXPOSE 80 443

# launch command
CMD ["/init"]
