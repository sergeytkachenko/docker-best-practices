#!/bin/bash
docker run -d \
	--name gs-web-indexing-service \
	-e RabbitConfiguration__RabbitMQUri="$GS_RABBITMQ_AMQP" \
	-e RabbitConfiguration__ConnectAttempts="$RABBITMQ_CONNECT_ATTEMPTS" \
	-e RabbitConfiguration__ReconnectInterval="$RABBITMQ_RECONNECT_INTERVAL" \
	-e RabbitConfiguration__NetworkRecoveryInterval="$RABBITMQ_NETWORK_RECOVERY_INTERVAL" \
	-e IndexEntityPublisherConfiguration__QueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_TASK" \
	-e QueriedIndexEntityPublisherConfiguration__QueueName="$GS_RABBITMQ_QUEUE_NAME_SINGLE_QUERIED_TASK_INBOX" \
	--net net1 \
	--add-host rabbitmq:"$RABBITMQ_IP" \
	--add-host gs-mysql:"$MYSQL_IP" \
	-p $WEB_INDEXING_SERVICE_PORT:80 \
	"$DOCKER_HUB_LOGIN""gs-web-indexing-service:""$DOCKER_TAG"
