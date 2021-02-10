
HUB_USER=alpined
IMAGE_NAME=$(shell basename $(CURDIR))
IMAGE_FULL=$(HUB_USER)/$(IMAGE_NAME)

all: pull build

pull:
	docker pull alpine:latest

build:
	docker build --no-cache -t $(IMAGE_FULL) .

buildc:
	docker build -t $(IMAGE_FULL) .

