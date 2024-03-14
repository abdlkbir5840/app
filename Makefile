setup:
	@make build
	@make up 
	@make down 
	@make serve
	@make composer-update
	@make data

build:
	docker-compose build --no-cache --force-rm

stop:
	docker-compose stop

up:
	docker-compose up -d

down:
	docker-compose stop
	docker-compose down

composer-update:
	docker exec laravel-app-01 bash -c "composer update"
	docker exec laravel-app-02 bash -c "composer update"

data:
	docker exec laravel-app-01 php artisan migrate
	docker exec laravel-app-01 php artisan db:seed
	docker exec laravel-app-02 php artisan migrate
	docker exec laravel-app-02 php artisan db:seed

serve:
	docker-compose exec laravel-app-01 php artisan serve
