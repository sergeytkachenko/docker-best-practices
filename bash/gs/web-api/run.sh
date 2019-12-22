#!/bin/bash
docker run -d \
	--name gs-web-api \
	-e DbDialectProvider="$GS_COMMON_DB_DIALECT_PROVIDER" \
	-e ApiKey="$GS_API_KEY" \
	-e RequestTimeOut="$GS_REQUEST_TIMEOUT" \
	-e elasticLogin="$GS_ES_LOGIN" \
	-e elasticPassword="$GS_ES_PASSWORD" \
	-e elasticSearchUrl="$GS_ES_URL" \
	-e publicElasticSearchUrl="$GS_PUBLIC_ES_URL" \
	-e connectionStrings__db="$GS_DB_CONNECTION_STRING" \
	-e connectionStrings__RabbitMQ="$GS_RABBITMQ_AMQP" \
	-e connectionStrings__redis="$GS_REDIS_CONNECTION_STRING" \
	-e RabbitMQSettings__DataCenterName="$GS_DATACENTER_NAME" \
	-e RabbitMQSettings__AppVersion="$APP_VERSION" \
	--net net1 \
	--add-host elasticsearch:"$ELASTICSEARCH_IP" \
	--add-host gs-mysql:"$MYSQL_IP" \
	--add-host gs-redis:"$REDIS_IP" \
	-p $WEB_API_PORT:80 \
	"$DOCKER_HUB_LOGIN""gs-web-api:""$DOCKER_TAG"
