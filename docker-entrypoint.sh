#!/bin/sh
set -e

test -d /etc/redis || {
  mkdir -p /etc/redis
  chown redis:redis -R /etc/redis
}

test -f /etc/redis/redis.conf || {
  echo "port ${PORT}" > /etc/redis/redis.conf
  echo "cluster-enabled yes" >> /etc/redis/redis.conf
  echo "cluster-config-file /etc/redis/nodes.conf" >> /etc/redis/redis.conf
  echo "cluster-node-timeout 5000" >> /etc/redis/redis.conf
  echo "appendonly yes" >> /etc/redis/redis.conf
  chown redis:redis -R /etc/redis
}

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	find . \! -user redis -exec chown redis '{}' +
	exec gosu redis "$0" "$@"
fi

exec "$@"
