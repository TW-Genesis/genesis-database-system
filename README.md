# Genesis Database System

This package contains following sources:

- Ontologies
- Docker image build and deployment files
- Data used in simulation

## Starting Database Server

Here we are using Fuseki as a databae server and TDB2 as a database. The docker container is based on
[Fuseki main](https://jena.apache.org/documentation/fuseki2/fuseki-main)
for running a SPARQL server.

### Build

To manually build image you can run following command.

    docker-compose build

### Run

`docker-compose run` can be used to run the build from the previous section.

#### Step 1: Load database with data from Turtle file

This step needs to be performed only once for a dataset. You can load multiple files one by one using below command. Once you load the data, it will be persisted in the database. Default location is `./databases/<database-name>`. You can change the default location by updating `docker-compose.yaml` file.

    docker-compose run --rm fuseki --load-data testDB massSpec.ttl

- --load-data: Argument used to specify that you want to load data.
- testDB: database name
- massSpec.ttl: turtle file name

### Step 2: Start database server

Once data is loaded, you can start the database server.

    #read-only
    docker-compose run --rm --service-ports fuseki --tdb2 --loc databases/testDB /testDB

- databases/\<database-name>: Path of the testDB folder inside docker container.
- /testDB: SPARQL endpoint name.

To allow data updates on the database, add `--update`. Updates are persisted.

    docker-compose run --rm --service-ports fuseki --tdb2 --update --loc databases/testDB /testDB

If you don't want to load any data upfront, then just create empty folder with database name in databases folder and run above docker-compose run command.

    mkdir -p databases/<database-name>
    docker-compose run --rm --service-ports fuseki --tdb2 --update --loc databases/<database-name> /<endpoint-name>

See
[fuseki-docker](https://jena.apache.org/documentation/fuseki2/fuseki-docker.html)
for more information on how to spawn fuseki docker container.

## Accessing Sparql API

Once database has started, you can access SPARQL API by visiting http://localhost:3030/\<endpoint-name>

### Querying database

WIP
