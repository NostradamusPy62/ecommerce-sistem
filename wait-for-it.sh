#!/bin/sh

host="$1"
shift
cmd="$@"

until mysql -h "$host" -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1" &> /dev/null; do
  echo "Esperando a que MySQL ($host) esté listo..."
  sleep 2
done

exec $cmd
