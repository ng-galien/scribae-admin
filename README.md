# Scribae admin
---

Admin application for Scribae blogs

## Project Checkout

The project contains a submodule with the website prototypes

https://github.com/ng-galien/scribae-prototype.git

To retrieve the entire source code 

git clone --recurse-submodules https://github.com/ng-galien/scribae-admin.git

## Common tasks

### Liste des processus

>ps -ef | grep "jekyll" | awk '{print $2}')
>ps -ef | head -1; ps -ef | grep "jekyll"

### Tuer un processus commme ctrl-c

>kill -SIGINT pid

## Docker

> docker build -t scribae-admin .
> docker run -itP scribae-admin
> docker tag scribae-admin:latest nggalien/scribae-admin
> docker push nggalien/scribae-admin:latest

## Git submodule


## BUG:
pour la gallery des albums
mettre à jour le formulaire des positions dans le js erb de image
résoudre le probleme de max pos avec un local dans le partial


