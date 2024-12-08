build:
	DOCKER_BUILDKIT=1 docker build --no-cache -f backend/docker/laravel/Dockerfile -t backend backend/
	DOCKER_BUILDKIT=1 docker build --no-cache -f ml_api/docker/laravel/Dockerfile -t ml_api ml_api/
up:
	docker-compose up -d
train-ml:
	docker compose exec mlapi php artisan app:train-ml
validate-ml:
	docker compose exec mlapi php artisan app:validate-ml
init-data:
	docker-compose exec laravel php artisan app:get-and-set-to-storage-news
