# Using Scribae with docker

## Windows

## Mac / Linux

## Build the docker image


> docker build -t scribae-admin . --build-arg LOCALBUILD=true

> docker run -itP scribae-admin

> docker tag scribae-admin:latest nggalien/scribae-admin

> docker push nggalien/scribae-admin:latest