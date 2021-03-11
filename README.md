# Evaluacion Seguimiento App Genero
Gender app project developed for gender equity and equal opportunities for women.

# HOW TO INSTALL

### Technologies
  >
    1. Ruby: 2.5.8
    2. Unicorn: 5.5
    3. Postgresql: 12.5
    4. Docker: 20.10.2
    5. Docker-compose: 1.25.4

### Create ENV files

> touch .env.pg

    POSTGRES_USER=postgres
    POSTGRES_PASSWORD=postgres
    DB_NAME=genero
    DB_RESTORE_FILE=genero.sql

> touch .env.ruby

    SPROCKETS_CACHE=/cache
    APP_DATABASE_NAME=genero
    APP_DATABASE_NAME_DEV=genero_test
    APP_DATABASE_NAME_TEST=genero_test
    APP_DATABASE_USERNAME=postgres
    APP_DATABASE_PASSWORD=postgres

    USER_ADMIN_EMAIL=user_example@example.com
    USER_ADMIN_PASSWORD=a#p4SSw0rd

    POSTGRES_PASSWORD=postgres
    RAILS_MAX_THREADS=5

    # comment if you are in production env
    RAILS_ENV=development

    # comment if you are in development mode
    #RAILS_ENV=production

### Docker

> Install docker in your server

    sudo docker-compose build
    sudo docker-compose run --no-deps ruby bundle exec rake secrets
    sudo docker-compose run ruby rails db:create
    sudo docker-compose run ruby rails db:migrate

### Run database seed for create user administrator
  > 
    ## specify admin parameters (email, password) in .env.ruby file
    sudo docker-compose run bundle exec rake db:seed

### Precompile assets, this command precompile all images, javascripts and css
  >
    sudo docker-compose run ruby rails assets:precompile
    
### Start docker services
  >
    sudo docker-compose up -d
