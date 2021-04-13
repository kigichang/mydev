.PHONY: clean load save

PLANTUML_VERSION="1.2021.4"
GO_VERSION="1.16.3"
HOME=$(shell echo $$HOME)
UID=$(shell id -u)
GID=$(shell id -g)
USER=$(shell whoami)
PWD=$(shell pwd)

build:
	docker build -t mydev:$(GO_VERSION) \
		--build-arg UID=$(UID) \
		--build-arg GID=$(GID) \
		--build-arg USER=$(USER) \
		--build-arg PW=$(USER) \
		--build-arg GO_VERSION=$(GO_VERSION) .

go:
	docker build \
		--build-arg PLANTUML_VERSION=$(PLANTUML_VERSION) \
		--build-arg GO_VERSION=$(GO_VERSION) \
		-t mygo:$(GO_VERSION) \
		-f Dockerfile_go .

clean:
	-docker stop mygo
	-docker rm mygo
	-rm  mygo.tgz
	-docker rmi mygo:$(GO_VERSION)

run:
	-docker stop mydev
	-docker rm mydev
	docker run -it \
		--name mydev \
		-u $(UID):$(GID) \
		--network host \
		-v $(HOME)/.ssh:/home/$(USER)/.ssh:ro \
		-v /media/kigi/Data/projects:/home/$(USER)/projects:z \
		mydev:$(GO_VERSION) \
		/bin/zsh
