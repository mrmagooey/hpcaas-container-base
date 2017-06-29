NAME = mrmagooey/hpcaas-container-base
VERSION = 0.1.0

.PHONY: all build build_container_daemon test tag_latest release

all: build

build: build_container_daemon
	docker build -t $(NAME):$(VERSION) image

build_container_daemon:
	git submodule init
	cd image/hpcaas-container-daemon && make build-docker

test:
	env NAME=$(NAME) VERSION=$(VERSION) ./test/runner.sh

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag by creating an official GitHub release."
