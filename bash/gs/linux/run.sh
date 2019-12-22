#!/bin/bash
. Docker/linux/default-env

COMMON_DB_TYPE=$1
WORKER_DB_TYPE=$2
DOCKER_TAG=$3
TYPE=$4
export DOCKER_TAG=$DOCKER_TAG

if [ -z "$COMMON_DB_TYPE" ]; then
   echo "ERROR: You must set COMMON_DB_TYPE (mysql or mssql) 'Docker/linux/run.sh [COMMON_DB_TYPE] [WORKER_DB_TYPE] [DOCKER_TAG]'"
   exit
fi

if [ -z "$WORKER_DB_TYPE" ]; then
   echo "ERROR: You must set WORKER_DB_TYPE (mssql or oracle) 'Docker/linux/run.sh [COMMON_DB_TYPE] [WORKER_DB_TYPE] [DOCKER_TAG]'"
   exit
fi

if [ -z "$DOCKER_TAG" ]; then
   echo "ERROR: You must set DOCKER_TAG (example: 1.0) 'Docker/linux/run.sh [COMMON_DB_TYPE] [WORKER_DB_TYPE] [DOCKER_TAG]'"
   exit
fi

docker rm -f rabbitmq

docker rm -f es-node1
docker rm -f es-node2

docker rm -f gs-redis
docker rm -f gs-mysql

docker rm -f gs-scheduler

docker rm -f gs-worker-01
docker rm -f gs-worker-02
docker rm -f gs-worker-03

docker rm -f gs-worker-replay

docker rm -f gs-web-api

docker rm -f gs-web-indexing-service
docker rm -f gs-worker-single
docker rm -f gs-worker-single-replay
docker rm -f gs-worker-single-task
docker rm -f gs-worker-queried-single-task

if [ $COMMON_DB_TYPE = "mssql" ]; then
    echo "run . Docker/linux/mssql-env"
    . Docker/linux/mssql-env
fi

if [ $COMMON_DB_TYPE = "mysql" ]; then
    echo "run . Docker/linux/mysql-env"
    . Docker/linux/mysql-env
fi

if [ $WORKER_DB_TYPE = "oracle" ]; then
    echo "run . Docker/linux/oracle-env"
    . Docker/linux/oracle-env
fi

if [ $WORKER_DB_TYPE = "postgre" ]; then
    echo "run . Docker/linux/postgre-env"
    . Docker/linux/postgre-env
fi

if [ $TYPE = "onsite" ]; then
    echo "run . Docker/linux/onsite-custom-env"
    . Docker/linux/onsite-custom-env
fi

if [ $CLEAR_ELASTICSEARCH_DATA = 1 ]; then
    echo "run docker volume rm es1"
    echo "run docker volume rm es2"
    docker volume rm es1
    docker volume rm es2
fi

if [ $CLEAR_RABBITMQ_DATA = 1 ]; then
    echo "docker volume rm rabbitmq"
    docker volume rm rabbitmq
fi

if [ $CLEAR_MYSQL_DATA = 1 ]; then
    echo "docker volume rm mysql"
    docker volume rm mysql
fi

if [ $RUN_ELASTICSEARCH = 1 ]; then
   docker volume create es1
   docker volume create es2
fi

if [ $RUN_RABBITMQ = 1 ]; then
   docker volume create rabbitmq
fi

if [ $RUN_MYSQL = 1 ]; then
   docker volume create mysql
fi

docker network create --subnet=172.18.0.0/16 net1

if [ $RUN_ELASTICSEARCH = 1 ]; then
   echo "sh Docker/elasticsearch/build.sh"
   sh Docker/elasticsearch/build.sh
   echo "Docker/elasticsearch/run.sh"
   sh Docker/elasticsearch/run.sh
fi
if [ $RUN_RABBITMQ = 1 ]; then
   echo "sh Docker/rabbitmq/run.sh"
   sh Docker/rabbitmq/run.sh
fi
if [ $RUN_MYSQL = 1 ]; then
   echo "sh Docker/mysql/run.sh"
   sh Docker/mysql/run.sh
fi

if [ $RUN_REDIS = 1 ]; then
  echo "sh Docker/redis/run.sh"
  sh Docker/redis/run.sh
fi

sh Docker/scheduler/run.sh

# run 3 worker by defaul
sh Docker/worker/run.sh gs-worker-01
sh Docker/worker/run.sh gs-worker-02
sh Docker/worker/run.sh gs-worker-03

sh Docker/worker-replay/run.sh
sh Docker/web-api/run.sh

sh Docker/web-indexing-service/run.sh
sh Docker/worker-single/run.sh
sh Docker/worker-single-replay/run.sh
sh Docker/worker-single-task/run.sh
sh Docker/worker-queried-single-task/run.sh
