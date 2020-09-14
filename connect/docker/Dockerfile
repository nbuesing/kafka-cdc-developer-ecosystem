FROM confluentinc/cp-kafka-connect:5.5.1

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

RUN \
	rm -fr /usr/share/java/kafka-connect-* \
	&& rm -fr /usr/share/confluent-hub-components/confluentinc-kafka-connect-gcs \
	&& confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:5.5.1 \
	&& confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:5.5.1 \
	&& confluent-hub install --no-prompt debezium/debezium-connector-mysql:1.2.1 \
	&& mkdir -p /tmp/downloads \
	&& cd /tmp/downloads \
	&& curl -k -L -O https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.21.tar.gz \
	&& tar xfv mysql-connector-java-8.0.21.tar.gz -- mysql-connector-java-8.0.21/mysql-connector-java-8.0.21.jar \
	&& mv mysql-connector-java-8.0.21/mysql-connector-java-8.0.21.jar /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib \
	&& rm -fr /tmp/downloads

#https://www.oracle.com/database/technologies/jdbc-drivers-12c-downloads.html
#https://download.oracle.com/otn/utilities_drivers/jdbc/121010/ojdbc7.jar
COPY ./downloads/ojdbc7.jar /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib






