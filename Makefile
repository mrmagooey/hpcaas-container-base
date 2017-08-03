NAME = mrmagooey/hpcaas-container-base
VERSION = 0.1.1
DAEMON_VERSION = v0.1.0

.PHONY: all build build_container_daemon test tag_latest release

all: build

build: build_container_daemon
ifneq ($(and $(DOCKER_BUILD_NETWORK),$(DOCKER_BUILD_PROXY)),)
	docker build -t $(NAME):$(VERSION) --network $(DOCKER_BUILD_NETWORK) --build-arg http_proxy=$(DOCKER_BUILD_PROXY) image
else
	echo "No build proxy settings found"
	docker build -t $(NAME):$(VERSION) image
endif

build_container_daemon:
	git submodule init
	git submodule update --remote --merge
	cd image/hpcaas-container-daemon && git checkout $(DAEMON_VERSION) && make build-docker

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag by creating an official GitHub release."
