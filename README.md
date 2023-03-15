# Genesis Database System

This repository contains following resources :

- docker file for building server node container used in the genesis database system
- docker compose file for loading initial data and bringing up the genesis database system

### build containers

Clone this repository and run the following commands from the root of the repository:

    docker build -t genesis/rdf-data-server:latest ./rdf-data-server/

### Load database with initial data and start
    
-   The provided docker compose file can load turtle files located in the [data](data) folder in the database:
    ```bash
    DATA=<turtle file name> docker compose up load-data
    ```
    example: The file `./data/init.ttl` can be loaded using the following command:
    ```bash
    DATA=init.ttl docker compose up load-data
    ```
The above command will not overwrite any existing data in the database, but instead it will add new triples to the database if there are any.
-  Once data is successfully loaded, you can start the database system using following command:
    ```bash
    docker compose up start-server
    ```
### Querying database
Once database has started, you can query the database using exposed endpoint at port number 3030.  Here is an example http request to get count of all the triples in the database -

    curl  --data-urlencode "query=SELECT (COUNT(?s) AS ?triples) WHERE { ?s ?p ?o }" --get http://localhost:3030/genesis
