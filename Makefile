IMAGE_NAME = cpee
CONTAINER_ENGINE = docker

force-build:
	@${CONTAINER_ENGINE} build -t $(IMAGE_NAME) --no-cache .

build:
	@${CONTAINER_ENGINE} build -t $(IMAGE_NAME) .

.PHONY: test
test:
	@${CONTAINER_ENGINE} run --rm -it -p 8080:80 $(IMAGE_NAME)
