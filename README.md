# Warm hearts

## Intro

Project was created in fast way with multiple "TODOs" described in notion https://warm-hearts.notion.site/80a10e0fb5644e238726f5e80e21d677?v=c0bc0f74ad4b464cbe5a2fe473e6a7a2&pvs=4

Any pull requests are welcome.

## Development

Create network:

`$ docker network create warm-hearts`

- Before start run pg14 container `docker compose -f compose.development.yaml up -d`
- Create Database: `docker compose run app /bin/rails db:create`
- Run migrations if needed: `docker compose run app /bin/rails db:migrate`
- Run service `docker compose up`


NOTE: If you are not familiar with ruby on rails you can do it in your way, just edit HTML with static texts located in `app/views/home/index.html.erb`. All css are located in `assets/stylesheets/home.css`. All javascript files are located in `javascript/*`