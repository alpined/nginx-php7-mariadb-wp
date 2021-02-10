#! /bin/sh

my_term_handler() { 
  echo "Caught SIGTERM signal!" 
  kill -TERM "$child" 2>/dev/null
}

trap my_term_handler SIGTERM

php-fpm7 &

child=$! 
wait "$child"
