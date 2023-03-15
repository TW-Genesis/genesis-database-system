#!/bin/sh
## Licensed under the terms of http://www.apache.org/licenses/LICENSE-2.0

## env | sort
if [ $1 == "--load-data" ]
then
	exec "./apache-jena-$JENA_VERSION/bin/tdb2.tdbloader" --loc "${FUSEKI_DIR}/databases/genesis" "${FUSEKI_DIR}/data.ttl"
else
	exec "$JAVA_HOME/bin/java" $JAVA_OPTIONS -jar "${FUSEKI_DIR}/${FUSEKI_JAR}" --tdb2 --loc "databases/genesis" "/genesis"
fi
