# Genesis Database System

This repository contains following resources :

- docker file for building server node container used in the genesis database system
- docker compose file for loading initial data and bringing up the genesis database system

### Prerequisite: 
- docker or any other container runtime.

### build image

Clone this repository and run the following commands from the root of the repository:

    docker build -t genesis/rdf-data-server:latest ./rdf-data-server/

### Load database with initial data
    
-  The provided docker compose file can load turtle files located in the [data](data) folder in the database:
    
    ```bash
    DATA=<turtle-file-name> docker compose up load-data
    ```
   
   Example: The file `./data/sample.ttl` can be loaded using the following command:
    ```bash
    DATA=sample.ttl docker compose up load-data
    ```
The above command will do union of new triples with existing triples data. Currently, only one file can be added at a time. 

### Start database system

-  Once data is successfully loaded, you can start the database system using following command:
    ```bash
    docker compose up start-server
    ```
    It will expose sparql http endpoint which can be used to query the database
    
### Querying database
After database has started, you can query the database using exposed endpoint at defaulty port number 3030. Here is an example http request to get count of all the triples in the database -

    curl --data-urlencode "query=SELECT (COUNT(?s) AS ?triples) WHERE { ?s ?p ?o }" --get http://localhost:3030/genesis
