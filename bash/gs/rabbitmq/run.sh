#!/bin/bash
docker run -d \
	-v $RABBITMQ_VOLUME:/var/lib/rabbitmq \
	--net net1 \
	--ip 172.18.0.10 \
	--hostname rabbitmq \
	-p 15672:15672 \
	-p 5672:5672 \
	--name rabbitmq \
	-e RABBITMQ_DEFAULT_USER=gs \
	-e RABBITMQ_DEFAULT_PASS=gs \
	rabbitmq:3-management