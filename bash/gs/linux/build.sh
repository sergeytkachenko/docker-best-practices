#!/bin/bash
svn update
. Docker/linux/default-env

DOCKER_TAG=$1

if [ -z "$DOCKER_TAG" ]; then
   echo "ERROR: You must set DOCKER_TAG (example: 1.0) 'Docker/linux/build.sh [DOCKER_TAG]'"
   exit
fi

if [ $RUN_ELASTICSEARCH = 1 ]; then
   sh Docker/elasticsearch/build.sh
fi
if [ $RUN_RABBITMQ = 1 ]; then
   sh Docker/rabbitmq/build.sh
fi
sh Docker/worker-host/build.sh
sh Docker/scheduler/build.sh
sh Docker/worker/build.sh
sh Docker/worker-single/build.sh
sh Docker/worker-single-replay/build.sh
sh Docker/worker-single-task/build.sh
sh Docker/worker-replay/build.sh
sh Docker/web-api/build.sh
sh Docker/web-indexing-service/build.sh
sh Docker/worker-queried-single-task/build.sh

docker image rm -f "$DOCKER_HUB_LOGIN""gs-scheduler:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-worker:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-worker-single:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-worker-single-replay:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-web-api:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-web-indexing-service:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-worker-replay:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-worker-single-task:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-worker-host:""$DOCKER_TAG"
docker image rm -f "$DOCKER_HUB_LOGIN""gs-worker-queried-single-task:""$DOCKER_TAG"

docker tag gs-scheduler "$DOCKER_HUB_LOGIN""gs-scheduler:""$DOCKER_TAG"
docker tag gs-worker "$DOCKER_HUB_LOGIN""gs-worker:""$DOCKER_TAG"
docker tag gs-worker-single "$DOCKER_HUB_LOGIN""gs-worker-single:""$DOCKER_TAG"
docker tag gs-worker-single-replay "$DOCKER_HUB_LOGIN""gs-worker-single-replay:""$DOCKER_TAG"
docker tag gs-web-api "$DOCKER_HUB_LOGIN""gs-web-api:""$DOCKER_TAG"
docker tag gs-web-indexing-service "$DOCKER_HUB_LOGIN""gs-web-indexing-service:""$DOCKER_TAG"
docker tag gs-worker-single-task "$DOCKER_HUB_LOGIN""gs-worker-single-task:""$DOCKER_TAG"
docker tag gs-worker-replay "$DOCKER_HUB_LOGIN""gs-worker-replay:""$DOCKER_TAG"
docker tag gs-worker-host "$DOCKER_HUB_LOGIN""gs-worker-host:""$DOCKER_TAG"
docker tag gs-worker-queried-single-task "$DOCKER_HUB_LOGIN""gs-worker-queried-single-task:""$DOCKER_TAG"

docker push "$DOCKER_HUB_LOGIN""gs-scheduler:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-worker:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-worker-single:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-worker-single-replay:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-web-api:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-web-indexing-service:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-worker-single-task:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-worker-replay:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-worker-host:""$DOCKER_TAG"
docker push "$DOCKER_HUB_LOGIN""gs-worker-queried-single-task:""$DOCKER_TAG"