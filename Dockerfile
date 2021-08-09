FROM redis:6

#ARG PORT=7000

#RUN mkdir -p /etc/redis
#RUN touch /etc/redis/redis.conf
#RUN echo "port ${PORT}" > /etc/redis/redis.conf
#RUN echo "cluster-enabled yes" >> /etc/redis/redis.conf
#RUN echo "cluster-config-file /etc/redis/nodes.conf" >> /etc/redis/redis.conf
#RUN echo "cluster-node-timeout 5000" >> /etc/redis/redis.conf
#RUN echo "appendonly yes" >> /etc/redis/redis.conf
#RUN chown redis:redis -R /etc/redis

COPY docker-entrypoint.sh /usr/local/bin/

VOLUME ["/etc/redis"]
#EXPOSE ${PORT}

CMD ["redis-server", "/etc/redis/redis.conf"]
