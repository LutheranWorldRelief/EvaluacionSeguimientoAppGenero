# Evaluacion Seguimiento App Genero
Gender app project developed for gender equity and equal opportunities for women.

# HOW TO INSTALL

### First install Postgresql

  > sudo apt install postgresql postgresql-contrib
 
### Configure Postgresql
  1. sudo -i -u postgres
  2. sudo -u postgres psql
  3. ALTER USER postgres WITH PASSWORD 'YOUR PASSWORD';
  
  4. Edit pg_hba.conf in /etc/postgresql/**YOU PSQL VERSION**/main/pg_hba.conf and change 
    
    *BEFORE*
    
    > host     all        postgres           your.ip your.subnet      peer
    
    *AFTER*
    
    > host     all        postgres           your.ip your.subnet      md5 
  
  5. Test your connection
    
    > psql -U postgres -W

### Install RVM
  >
    1. gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    2. curl -sSL https://get.rvm.io | bash -s stable
  
### Update the packages
  >
    apt-get update
    apt-get upgrade
    apt-get install build-essential

### get the packages required by ruby
  >
    rvm pkg install zlib
    rvm pkg install openssl

### Then, install Ruby 2.5.3
  >
    rvm install 2.5.3


### Install passenger
  >
    sudo apt-get install -y dirmngr gnupg
    
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
    
    sudo apt-get install -y apt-transport-https ca-certificates
    
    sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
    
    sudo apt-get update
    
    sudo apt-get install -y libapache2-mod-passenger
    
    sudo a2enmod passenger

    sudo apache2ctl restart

### Edit /etc/apache2/sites-available/000-default.conf
  >
    Inside your project VirtualHost, put

      1. **PassengerRoot /usr/local/rvm/gems/ruby-VERSION/gems/passenger-VERSION**
      2. **PassengerRuby /usr/local/rvm/wrappers/ruby-VERSION/ruby**

### Reload Apache2
  >
  /etc/init.d/apache2 reload
  
### Clone the project in /var/www/html
  > 
    git clone https://github.com/codecastlesv/EvaluacionSeguimientoAppGenero.git

## IMPORTANT! EVER EXPORT YOUR ENVIROMENT WHEN YOUR CONNECT WITH THE SERVER BY SSH
 > 
  export RAILS_ENV=production

### Install gems
  >
    1. cd /var/www/html/EvaluacionSeguimientoAppGenero/
    2. bundle install

### Generate secret token for requests and paste it, in production key inside config/secrets.yml file
  >
    bundle exec rake secrets

## Modify your connection database settings in config/database.yml and put your postgresql's (user, password and database name) credentials in production key

### Create database and run migrations
  >
    1. bundle exec rake db:create
    2. bundle exec rake db:migrate

### Run database seed for create user administrator
  >
    1. bundle exec rake db:seed

### Precompile assets, this command precompile all images, javascripts and css
  >
    1. bundle exec rake assets:precompile
    
### Restart the services
  >
    1. touch tmp/restart.txt
    2. /etc/init.d/apache2 restart
