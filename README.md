# Genesis Database System

This repository contains following resources :

- Docker file for building server node container used in the genesis database system
- Docker compose file for loading initial data and bringing up the genesis database system

### Prerequisites

- Docker or any other container runtime.

### Bbuild image

Clone this repository and run the following commands from the root of the repository:

```bash
docker build -t genesis/rdf-data-server:latest ./rdf-data-server/
```

### Load database with initial data
    
The provided Docker compose file can load turtle files located in the [data](data) folder in the database:
    
```bash
DATA=<turtle-file-name> docker compose up load-data
```

Example: The file `./data/sample.ttl` can be loaded using the following command:
```bash
DATA=sample.ttl docker compose up load-data
```

The above command will do union of new triples with existing triples data. Currently, only one file can be added at a time. 

### Start database system

Once data is successfully loaded, you can start the database system using following command:
    
```bash
docker compose up start-server -d
```

which will expose SPARQL HTTP endpoint which can be used to query the database.
    
### Querying database

After database has started, you can query the database using exposed endpoint at default port number 3033. Here is an example http request to get count of all the triples in the database:

```bash
curl --data-urlencode "query=SELECT (COUNT(?s) AS ?triples) WHERE { ?s ?p ?o }" --get http://localhost:3033/genesis
```

which runs the SPARQL query:

```sparql
SELECT (COUNT(?s) AS ?triples) WHERE { ?s ?p ?o }
```

### Shutting down the server

Shutting down the server can be done gracefully using the command:

```bash
docker compose down start-server
```