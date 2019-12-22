#!/bin/bash
. Docker/linux/default-env

docker push "$DOCKER_HUB_LOGIN""gs-scheduler"
docker push "$DOCKER_HUB_LOGIN""gs-worker"
docker push "$DOCKER_HUB_LOGIN""gs-worker-single"
docker push "$DOCKER_HUB_LOGIN""gs-web-api"
docker push "$DOCKER_HUB_LOGIN""gs-web-indexing-service"
docker push "$DOCKER_HUB_LOGIN""gs-worker-replay"
docker push "$DOCKER_HUB_LOGIN""gs-worker-host"
docker push "$DOCKER_HUB_LOGIN""gs-worker-queried-single-task"