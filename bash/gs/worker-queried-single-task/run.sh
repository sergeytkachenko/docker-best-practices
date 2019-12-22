#!/bin/bash
docker run -d \
	--name gs-worker-queried-single-task \
	-e DbDialectProvider="$GS_WORKER_DB_DIALECT_PROVIDER" \
	-e elasticLogin="$GS_ES_LOGIN" \
	-e elasticPassword="$GS_ES_PASSWORD" \
	-e OnSiteClientSettings__ElasticSearchUrl="$GS_ES_URL" \
	-e RabbitConfiguration__RabbitMQUri="$GS_RABBITMQ_AMQP" \
	-e RabbitConfiguration__ConnectAttempts="$RABBITMQ_CONNECT_ATTEMPTS" \
	-e RabbitConfiguration__ReconnectInterval="$RABBITMQ_RECONNECT_INTERVAL" \
	-e RabbitConfiguration__NetworkRecoveryInterval="$RABBITMQ_NETWORK_RECOVERY_INTERVAL" \
	-e IndexEntityPublisherConfiguration__QueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_TASK" \
	-e RabbitConsumerConfiguration__QueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_QUERIED_TASK_INBOX" \
	-e ElasticScrollConfiguration__ScrollBatchSize="$ES_SCROLL_BATCH_SIZE" \
	-e ElasticScrollConfiguration__ScrollTimeout="$ES_SCROLL_TIMEOUT" \
	--net net1 \
	--add-host rabbitmq:"$RABBITMQ_IP" \
	--add-host elasticsearch:"$ELASTICSEARCH_IP" \
	"$DOCKER_HUB_LOGIN""gs-worker-queried-single-task:""$DOCKER_TAG"

