current-dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SHELL = /bin/sh

.DEFAULT_GOAL := help

.PHONY: build
build:
	docker-compose -f docker-compose.yml build

.PHONY: help
help:
	@echo ''
	@echo 'Use "make {option}" to execute one of the following options'
	@echo ''
	@echo 'Options: '
	@echo '    build                 Build project docker images'
	@echo '    start                 Start all containers'
	@echo '    stop                  Stop all the containers'
	@echo '    clean                 Remove all the containers'
	@echo '    pull                  Download containers images'
	@echo '    logs                  Show the log of all services'
	@echo '    help (default)        Show make options'

.PHONY: start
start:
	docker-compose -f docker-compose.yml up -d

.PHONY: stop
stop:
	docker-compose -f docker-compose.yml stop

.PHONY: clean
clean: stop
	docker-compose -f docker-compose.yml rm -f

.PHONY: pull
pull:
	@docker-compose -f docker-compose.yml pull --ignore-pull-failures

.PHONY: logs
logs:
	docker-compose -f docker-compose.yml logs --tail=100 -f
