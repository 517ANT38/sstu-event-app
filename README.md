# sstu-event-app

## Для сборки
DOCKER_BUILDKIT=1 docker build --no-cache -f docker/laravel/Dockerfile -t backend .
## Для запуска
docker-compose up -d