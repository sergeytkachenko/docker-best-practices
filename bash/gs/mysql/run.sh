docker run -d \
	-v $MYSQL_VOLUME:/var/lib/mysql \
	--name gs-mysql \
	--net net1 \
	--ip $MYSQL_IP \
	--hostname gs-mysql \
	-p 3306:3306 \
	-e MYSQL_DATABASE=gs \
	-e MYSQL_ROOT_PASSWORD=$MYSQL_PASSWORD \
	-e MYSQL_ROOT_HOST=% \
	mysql:5.6