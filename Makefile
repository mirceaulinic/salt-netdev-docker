export PROXYID ?= dummy
export SALT_CLONE_DIR ?= $(HOME)/salt

.PHONY: start
start:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose down

.PHONY: env
env:
	docker-compose down
	docker-compose up -d

.PHONY: proxy
proxy:
	docker rm -f salt-proxy-$(PROXYID)
	docker-compose up -d
