NAPALM_LOGS ?= n
export PROXYID ?= dummy

export VERSION ?= $(shell cat ./VERSION)
DOCKERFILE_MASTER ?= Dockerfile-master
DOCKERFILE_PROXY ?= Dockerfile-proxy
DOCKER_BUILD_CONTEXT ?= .
USERNAME ?= mirceaulinic

.PHONY: build
build:
	docker build -f $(DOCKERFILE_MASTER) -t $(USERNAME)/salt-master:$(VERSION) $(DOCKER_BUILD_CONTEXT) --build-arg version="${VERSION}"
	docker build -f $(DOCKERFILE_PROXY) -t $(USERNAME)/salt-proxy:$(VERSION) $(DOCKER_BUILD_CONTEXT) --build-arg version="${VERSION}"

.PHONY: publish
publish: build
	echo "$(DOCKER_PASSWORD)" | docker login -u "$(DOCKER_USERNAME)" --password-stdin
	docker push $(USERNAME)/salt-master:$(VERSION)
	docker push $(USERNAME)/salt-proxy:$(VERSION)

.PHONY: start
start:
	docker-compose up -d
