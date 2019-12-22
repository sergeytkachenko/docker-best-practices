#!/bin/bash
docker run -d \
	--name gs-worker-single-task \
	-e DbDialectProvider="$GS_COMMON_DB_DIALECT_PROVIDER" \
	-e connectionStrings__db="$GS_DB_CONNECTION_STRING" \
	-e connectionStrings__RabbitMQ="$GS_RABBITMQ_AMQP" \
	-e connectionStrings__redis="$GS_REDIS_CONNECTION_STRING" \
	-e RabbitMQSettings__RabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_TASK" \
	-e RabbitMQSettings__ReplyRabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_INBOX" \
	-e RabbitMQSettings__DBServerNameTemplate="$GS_DB_SERVER_NAME_TEMPLATE" \
	-e RabbitMQSettings__AppVersion="$APP_VERSION" \
	--net net1 \
	--add-host gs-mysql:"$MYSQL_IP" \
	--add-host gs-redis:"$REDIS_IP" \
	--add-host rabbitmq:"$RABBITMQ_IP" \
	"$DOCKER_HUB_LOGIN""gs-worker-single-task:""$DOCKER_TAG"
