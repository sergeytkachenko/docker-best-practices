#!/bin/bash
docker run -d \
	--name gs-worker-replay \
	-e DbDialectProvider="$GS_COMMON_DB_DIALECT_PROVIDER" \
	-e connectionStrings__db="$GS_DB_CONNECTION_STRING" \
	-e connectionStrings__RabbitMQ="$GS_RABBITMQ_AMQP" \
	-e RabbitMQSettings__RabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_INBOX" \
	-e RabbitMQSettings__ReplyRabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_OUTBOX" \
	--net net1 \
	--add-host rabbitmq:"$RABBITMQ_IP" \
	"$DOCKER_HUB_LOGIN""gs-worker-replay:""$DOCKER_TAG"