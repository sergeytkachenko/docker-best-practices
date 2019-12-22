#!/bin/bash
docker run -d \
	--name gs-redis \
	--net net1 \
	--ip $REDIS_IP \
	--hostname gs-redis \
	-p 6379:6379 \
  redis
