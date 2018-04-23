#!/bin/bash
mkdir salsa/tmp/db/postgres-data -p
mkdir salsa/tmp/log -p

cp -n salsa/config/deploy/default/config.yml salsa/config/
cp -n salsa/config/deploy/default/database.yml salsa/config/

sudo docker-compose build
sudo docker-compose run salsa rake db:create
sudo docker-compose run salsa rake db:migrate
sudo docker-compose run salsa rake db:seed

bash generate_secrets.sh
