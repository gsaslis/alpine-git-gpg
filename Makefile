NAMESPACE := gsaslis
IMAGE_REPOSITORY := alpine-git-gpg
TAG := test

IMAGE := $(NAMESPACE)/$(IMAGE_REPOSITORY):$(TAG)

DOCKER_RUN_COMMAND := docker run --rm --entrypoint="" $(IMAGE)


build:
	docker build --tag $(IMAGE) .

test: build gpg-test git-test user-test

gpg-test:
	$(DOCKER_RUN_COMMAND) gpg --version

git-test:
	$(DOCKER_RUN_COMMAND) git --version

user-test:
	$(DOCKER_RUN_COMMAND) /usr/bin/fixUser.sh

.PHONY: build test git-test gpg-test user-test