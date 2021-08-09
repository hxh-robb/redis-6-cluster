#!/usr/bin/env bash


MY_IP=192.168.254.103
docker exec athena_redis-7000_1 redis-cli --cluster create ${MY_IP}:7000 ${MY_IP}:7001 ${MY_IP}:7002 ${MY_IP}:7003 ${MY_IP}:7004 ${MY_IP}:7005 --cluster-replicas 1 --cluster-yes
