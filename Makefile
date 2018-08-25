NAME = nginx-php5.6

build:
	docker build -t $(NAME) .
run:
	docker run -d -p 80:80 --name $(NAME) $(NAME)
exec:
	docker exec -it $(NAME) /bin/bash
clean:
	docker stop $(NAME) && docker rm $(NAME)
