# increase version before deploy
VERSION = 1.0
NAME = nginx-php5.6
IMAGE_NAME = navidonskis/nginx-php5.6

build:
	docker build -t $(NAME) .
run:
	docker run -d -p 80:80 --name $(NAME) $(NAME)
exec:
	docker exec -it $(NAME) /bin/bash
clean:
	docker stop $(NAME) && docker rm $(NAME)
deploy:
	# build an image and tag a latest version
	@$(MAKE) build
	# tag and increase version
	docker tag $(NAME) $(IMAGE_NAME):$(VERSION)
	docker tag $(NAME) $(IMAGE_NAME):latest
	# push to registry
	docker push $(IMAGE_NAME)
