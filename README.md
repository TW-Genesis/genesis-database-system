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

- `--load-data`: Argument used to specify that you want to load data.
- `testDB`: database name
- `massSpec.ttl`: turtle file name

### Step 2: Start database server

Once data is loaded, you can start the database server.

    #read-only
    docker-compose run --rm --service-ports fuseki --tdb2 --loc databases/testDB /testDB

- `databases/<database-name>`: Path of the testDB folder inside docker container.
- `/testDB`: SPARQL dataset endpoint name.

To allow data updates on the database, add `--update`. Updates are persisted.

    docker-compose run --rm --service-ports fuseki --tdb2 --update --loc databases/testDB /testDB

If you don't want to load any data upfront, then just create empty folder with database name in databases folder and run above docker-compose run command.

    mkdir -p databases/<database-name>
    docker-compose run --rm --service-ports fuseki --tdb2 --update --loc databases/<database-name> /<endpoint-name>

See
[fuseki-docker](https://jena.apache.org/documentation/fuseki2/fuseki-docker.html)
for more information on how to spawn fuseki docker container.

## Accessing Sparql API

Once database has started, you can access following SPARQL API services:

- HTTP: `http://localhost:3030/<endpoint-name>/data`
- Query: `http://localhost:3030/<endpoint-name>/query` or `http://localhost:3030/<endpoint-name>/sparql`
- Update: `http://localhost:3030/<endpoint-name>/update`

### Querying database
This package contains helper scripts in scripts folder to query the database. `s-query --service=service-endpoint "your sparql query"`. Here is an example -

    #export path of scripts folder
    export PATH=$PATH:$PWD/scripts

    s-query --service=http://localhost:3030/testDB "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    SELECT * WHERE {
    ?sub ?pred ?obj .
    } LIMIT 10"

### Put data in Database with data file
You can use below command to add data into database.

    s-put http://localhost:3030/testDB/data default data/ccp.ttl --verbose

- testDB: SPARQL dataset endpoint name.
- default: name of the graph
- data/massSpec.ttl: relative path of file from current directory