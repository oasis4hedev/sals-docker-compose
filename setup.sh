#!/bin/bash
mkdir salsa/tmp/db/postgres-data -p
mkdir salsa/tmp/log -p

cp -n salsa/config/deploy/default/config.yml salsa/config/
cp -n salsa/config/deploy/default/database.yml salsa/config/

docker-compose build
docker-compose run salsa rake db:create
docker-compose run salsa rake db:migrate
docker-compose run salsa rake db:seed

bash salsa/generate_secrets.sh
