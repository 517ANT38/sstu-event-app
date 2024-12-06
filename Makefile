build:
	DOCKER_BUILDKIT=1 docker build --no-cache -f backend/docker/laravel/Dockerfile -t backend backend/
	DOCKER_BUILDKIT=1 docker build --no-cache -f ml_api/docker/laravel/Dockerfile -t ml_api ml_api/
up:
	docker-compose up -d
install-or-update-deps:
	docker compose exec laravel composer update laravel/framework
	docker compose exec laravel composer install
init-data:
	docker-compose exec laravel php artisan app:get-and-set-to-storage-news
