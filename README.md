# Dockerizing PostgreSQL Beta.
## PostgreSQL Beta/RC Releases and Development snapshots (unstable).

Source code tarballs are built automatically every night on the official PostgreSQL development server. The development snapshot is taken from the head of the git repository, and includes the new features being worked on for the next release.

If you want to test the last beta postgresql version then clone this repository and deploy this container.

* First, you need to have installed Docker.

* Build an image from the Dockerfile and assign it a name.

``` docker build -t postgres:dev . ``` 

* Run the PostgreSQL server container

``` docker run -d --name pg13 -p 5433:5433 postgres:dev ```

In this moment PG13 is the current beta version, so I've used pg13 as name.

* Log in 

``` psql -U postgres -p 5433 -h localhost ``` 

Note that I've configured port access on 5433. See it in Dockerfile.




