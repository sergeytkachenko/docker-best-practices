#!/bin/bash
docker run -d \
	--name gs-worker-single-replay \
	-e DbDialectProvider="$GS_COMMON_DB_DIALECT_PROVIDER" \
	-e connectionStrings__db="$GS_DB_CONNECTION_STRING" \
	-e connectionStrings__RabbitMQ="$GS_RABBITMQ_AMQP" \
	-e RabbitMQSettings__RabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_INBOX" \
	-e RabbitMQSettings__ReplyRabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_OUTBOX" \
	-e RabbitMQSettings__IncrementDays="$GS_DB_INCREMENT_DAYS" \
	--net net1 \
	--add-host gs-mysql:"$MYSQL_IP" \
	--add-host rabbitmq:"$RABBITMQ_IP" \
	"$DOCKER_HUB_LOGIN""gs-worker-single-replay:""$DOCKER_TAG"
