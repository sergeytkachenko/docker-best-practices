#!/bin/bash
docker run -d \
	-v $ES1_VOLUME:/usr/share/elasticsearch/data \
	-e cluster.name=es-cluster \
	-e xpack.security.enabled=false \
	-e xpack.monitoring.enabled=false \
	-e xpack.ml.enabled=false \
	-e xpack.graph.enabled=false \
	-e xpack.watcher.enabled=false \
	-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
	--net net1 \
	--ip $ELASTICSEARCH_IP \
	--hostname elasticsearch \
	-p 9200:9200 \
	-p 9300:9300 \
	--name es-node1 \
	elasticsearch

docker run -d \
	-v $ES2_VOLUME:/usr/share/elasticsearch/data \
	-e cluster.name=es-cluster \
	-e xpack.security.enabled=false \
	-e xpack.monitoring.enabled=false \
	-e xpack.ml.enabled=false \
	-e xpack.graph.enabled=false \
	-e xpack.watcher.enabled=false \
	-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
	-e "discovery.zen.ping.unicast.hosts=es-node1" \
	--net net1 \
	--name es-node2 \
	elasticsearch
