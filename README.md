# Docker example for Symfony4

Complete stack run with docker and [docker-compose](https://docs.docker.com/compose/) with **PHP7.2-FPM - NGINX - MySQL 8** and **REDIS**.

## Installation

1. Create a `.env` from the `.env.example` file. Adapt it according to your symfony application

    ```bash
    cp .env.example .env
    ```


2. Build/run containers with

    ```bash
    $ docker-compose up -d
    ```

## Activate xDebug

Open your .env and find

```
# xDebug
XDEBUG_REMOTE_ENABLE=0
XDEBUG_REMOTE_HOST=your-local-ip
```

Change ```XDEBUG_REMOTE_ENABLE=0``` to ```XDEBUG_REMOTE_ENABLE=1``` and ```your-local-ip```
with the local IP of your computer, in my case ```192.168.0.12```. The result is something like:

```
# xDebug
XDEBUG_REMOTE_ENABLE=1
XDEBUG_REMOTE_HOST=192.168.0.12
```


Restart the php-fpm container:

```bash
$ docker stop php-fpm
$ docker-compose up -d
```

## Useful commands

```bash
# bash commands
$ docker-compose exec php bash

# Composer (e.g. composer update)
$ docker-compose exec php composer update

# MySQL commands
$ docker-compose exec db mysql -uroot -p"root"

# Check CPU consumption
$ docker stats $(docker inspect -f "{{ .Name }}" $(docker ps -q))

# Delete all containers
$ docker rm $(docker ps -aq)

# Delete all images
$ docker rmi $(docker images -q)
```    