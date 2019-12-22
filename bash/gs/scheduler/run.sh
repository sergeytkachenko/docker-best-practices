#!/bin/bash
docker run -d \
	--name gs-scheduler \
	-e DbDialectProvider="$GS_COMMON_DB_DIALECT_PROVIDER" \
	-e connectionStrings__db="$GS_DB_CONNECTION_STRING" \
	-e connectionStrings__RabbitMQ="$GS_RABBITMQ_AMQP" \
	-e RabbitMQSettings__RabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_INBOX" \
	-e RabbitMQSettings__ReplyRabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_OUTBOX" \
	-e RabbitMQSettings__FillQueueInterval="$GS_DB_FILL_QUEUE_INTERVAL" \
	-e RabbitMQSettings__DataCenterName="$GS_DATACENTER_NAME" \
	-e RabbitMQSettings__DBServerNameTemplate="$GS_DB_SERVER_NAME_TEMPLATE" \
	-e RabbitMQSettings__AppVersion="$APP_VERSION" \
	--net net1 \
	--add-host rabbitmq:"$RABBITMQ_IP" \
	--add-host gs-mysql:"$MYSQL_IP" \
	"$DOCKER_HUB_LOGIN""gs-scheduler:""$DOCKER_TAG"