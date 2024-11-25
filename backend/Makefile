build:
	DOCKER_BUILDKIT=1 docker build --no-cache -f docker/laravel/Dockerfile -t backend .
up:	
	docker-compose up -d
init-data:	
	docker-compose exec laravel php artisan app:get-and-set-to-storage-news
