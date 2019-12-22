#!/bin/bash
WORKER_NAME=$1
if [ -z "$WORKER_NAME" ]; then
   echo "ERROR: You must set WORKER_NAME (example: gs-worker-01) 'Docker/worker/run.sh [WORKER_NAME]'"
   exit
fi
docker run -d \
	--name $WORKER_NAME \
	-e DbDialectProvider="$GS_WORKER_DB_DIALECT_PROVIDER" \
	-e DBConnectionConfigPattern="$GS_WORKER_DB_CONNECTION_STRING_PATTERN" \
	-e elasticLogin="$GS_ES_LOGIN" \
	-e elasticPassword="$GS_ES_PASSWORD" \
	-e RequestTimeOut="$GS_REQUEST_TIMEOUT" \
	-e OnSiteClientSettings__ElasticSearchUrl="$GS_ES_URL" \
	-e connectionStrings__db="$GS_DB_CONNECTION_STRING" \
	-e connectionStrings__RabbitMQ="$GS_RABBITMQ_AMQP" \
	-e RabbitMQSettings__RabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_INBOX" \
	-e RabbitMQSettings__ReplyRabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_OUTBOX" \
	-e RabbitMQSettings__IncrementDays="$GS_DB_INCREMENT_DAYS" \
	--net net1 \
	--add-host rabbitmq:"$RABBITMQ_IP" \
	--add-host elasticsearch:"$ELASTICSEARCH_IP" \
	"$DOCKER_HUB_LOGIN""gs-worker:""$DOCKER_TAG"