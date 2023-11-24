# Warm hearts

## Development

Create network:

`$ docker network create warm-hearts`

- Before start run pg14 container `docker compose -f compose.development.yaml up -d`
- Create Database: `docker compose run app /bin/rails db:create`
- Run migrations if needed: `docker compose run app /bin/rails db:migrate`
- Run service `docker compose up`
