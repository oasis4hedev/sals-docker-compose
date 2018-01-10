# salsa-docker-compose install process

Clone repository with submodules

    git clone --recursive git@github.com:oasis4hedev/salsa-docker-compose.git
    cd salsa-docker-compose

### Setup Docker (for postgresql db)

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    sudo apt-get update
    sudo apt-get install docker-ce

### Install docker composer (as root)

    sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.15.0/docker-compose-$(uname -s)-$(uname -m)"

    chmod +x /usr/local/bin/docker-compose

### Setup salsa

    sh setup.sh

#### Database commands

    sudo docker-compose run salsa rake db:create
    sudo docker-compose run salsa rake db:migrate
    sudo docker-compose run salsa rake db:seed

#### Build (only if Gemfile or Dockerfile change)

    sudo docker-compose build

### Running the application

    sudo docker-compose up

    First time for a new hostname (support multi-tennants via differnet hostnames) visit http://0.0.0.0:3000/admin/organizations/new

    Slug must be hostname used to access site (i.e. `0.0.0.0` if using http://0.0.0.0:3000/ or `salsa.dev` if using http://salsa.dev:3000/, etc...)

    or just go to http://localhost:3000/admin/organizations if you have used the database seed command

    There are already some organizations created if you run the database seed command
    there are also documents created but you still need to publish them by going to the abandoned link on the org show page and



### Stopping application

    sudo docker-compose down

### Other useful docker commands

    docker images #list all docker images
    sudo docker rmi ########    #remove docker image id from above command (useful to recreate db or application image if needed)

##### debuging
  attach to rails app for debugger

    docker attach salsadockercompose_salsa_1

  to get name

    docker-compose images

  ctrl + p + q will detatch without exiting the process (ctrl + c) will cacnel the process

  example of how to use debugger that will activate the debugger when trying to load admin/organization/show page

    class OrganizationsController < AdminController
      def show
        debugger
        get_documents params[:slug]
      end  
    end


#### Running the queue (que gem)

    sudo docker-compose exec salsa sh
    cd /home/apps/salsa && RAILS_ENV=development que ./config/environment.rb

    #adding a report through rake
    cd /home/apps/salsa && rake RAILS_ENV=development report:generate_report[2,'FL17']

### Logs

Logs are shared with host, so you can view logs via on host via:

    tail -f salsa/logs/*.log
