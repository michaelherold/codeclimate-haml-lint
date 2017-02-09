.PHONY: image test

IMAGE_NAME ?= codeclimate/codeclimate-haml_lint

image:
	docker build --rm -t ${IMAGE_NAME} .

test:
	docker run --rm ${IMAGE_NAME} sh -c "cd /usr/src/app && bundle exec rake"
