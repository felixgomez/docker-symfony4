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

## Environments

You can configure some environments:

- Normal enviroment (DOCKER_ENVIRONMENT=)
- Debug enviroment (DOCKER_ENVIRONMENT=Debug)
- Blackfire environment (DOCKER_ENVIRONMENT=Blackfire)
- Use Apache instead Nginx (DOCKER_ENVIRONMENT=Apache)

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

Activate de Debug enviroment

```
DOCKER_ENVIRONMENT=Debug
```

Restart the php-fpm container forcing the rebuild:

```bash
$ docker stop php-fpm
$ docker-compose up -d --build
```

### Connect phpStorm with xDebug

#### Add docker

In Settings => Build, Execution, Deployment => Docker

Create new:

- Name: Docker
- Connect to Docker daemon with: TCP Socker and Engine API URL tcp:localhost:2375

If you are in Windows go to Docker Settings, General and check the option 
"Expose daemon on tcp://localhost:2375 without TLD" and restart docker

#### Create the remote CLI Interpreter

In Settings => Languages & Frameworks => PHP 

Create a new CLI Interpreter:

- Name: Remote PHP 7.2
- Server: Docker
- Configuration file: the route to the docker-compose.yml
- Service: php-fpm

phpStorm autodetect php as PHP executable, the PHP version and the debugger.

#### Create the remote server

In Settings => Languages & Frameworks => PHP => Servers

You must create a new server:

- Name: localhost
- Host: http://localhost
- Port: 8080
- Debugger: Xdebug

And you can set manual mapping for application folder

#### Activate Debug

Go to Settings => Languages & Frameworks => Debug

Check the pre-configuration steps. When all are OK, go to localhost:8080 in your browser, 
antivate the debug in the Xdebug extension, refresh the webpage and go.

If you change the serverName, you must change the value of ```XDEBUG_SERVER_NAME``` in your .env file

## Activate Blackfire


Open your .env and activate the Blackfire environment

```
DOCKER_ENVIRONMENT=Blackfire
```

You must be register at https://blackfire.io and go to your credentials page:

https://blackfire.io/my/settings/credentials

Copy the client and server credentials and paste them in the Blackfire section:

```
# Blackfire (blackfire environment)
BLACKFIRE_CLIENT_ID=YOUR_CLIENT_ID
BLACKFIRE_CLIENT_TOKEN=YOUR_CLIENT_TOKEN
BLACKFIRE_SERVER_ID=YOUR_SERVER_ID
BLACKFIRE_SERVER_TOKEN=YOUR_SERVER_TOKEN
```

Restart the php-fpm container forcing the rebuild:

```bash
$ docker stop php-fpm
$ docker-compose up -d --build
```

After the fisrt start in Blackfire mode you must restart the service to register the agent:

```
$ docker-compose exec php-fpm bash
$ /etc/init.d/blackfire-agent restart
```

Now you must install the chrome extension (or firefox if is your browser):

https://chrome.google.com/webstore/detail/blackfire-companion/miefikpgahefdbcgoiicnmpbeeomffld

With this extension installed, you can go to your site (http://localhost:8080) and run the profile easily

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