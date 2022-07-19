#!/bin/sh
## Licensed under the terms of http://www.apache.org/licenses/LICENSE-2.0

## env | sort
echo $@
if [ $1 == "--load-data" ]
then
  databaseName=$2
  ttlFile=$3
  exec "./apache-jena-$JENA_VERSION/bin/tdb2.tdbloader" --loc "${FUSEKI_DIR}/databases/$databaseName" "${FUSEKI_DATA_FILES_DIR}/$ttlFile"
else
  exec "$JAVA_HOME/bin/java" $JAVA_OPTIONS -jar "${FUSEKI_DIR}/${FUSEKI_JAR}" "$@"
fi
