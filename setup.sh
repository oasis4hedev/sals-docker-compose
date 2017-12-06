
mkdir salsa/tmp/db/postgres-data -p
cp salsa/config/deploy/default/* salsa/config/
sudo docker-compose build
sudo docker-compose run salsa rake db:create
sudo docker-compose run salsa rake db:migrate
sudo docker-compose run salsa rake db:seed

