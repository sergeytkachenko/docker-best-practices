#!/bin/bash
docker run -d \
	--name gs-worker-single \
	-e DbDialectProvider="$GS_WORKER_DB_DIALECT_PROVIDER" \
	-e DBConnectionConfigPattern="$GS_WORKER_DB_CONNECTION_STRING_PATTERN" \
	-e elasticLogin="$GS_ES_LOGIN" \
	-e elasticPassword="$GS_ES_PASSWORD" \
	-e RequestTimeOut="$GS_REQUEST_TIMEOUT" \
	-e OnSiteClientSettings__ElasticSearchUrl="$GS_ES_URL" \
	-e connectionStrings__RabbitMQ="$GS_RABBITMQ_AMQP" \
	-e RabbitMQSettings__RabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_INBOX" \
	-e RabbitMQSettings__ReplyRabbitQueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_OUTBOX" \
	--net net1 \
	--add-host rabbitmq:"$RABBITMQ_IP" \
	--add-host elasticsearch:"$ELASTICSEARCH_IP" \
	"$DOCKER_HUB_LOGIN""gs-worker-single:""$DOCKER_TAG"
