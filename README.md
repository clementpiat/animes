# Animes OST Playlist Generator

Small Rails app to generate a Youtube playlist of OSTs from the animes you have watched.

![Overview](https://raw.githubusercontent.com/clementpiat/animes/main/animes_rails_app.gif)

## Install

You will need `ruby 2.6.3`.

You can then use bundler to install the different dependencies.
```
gem install bundler
```
Then run this at the root of the project.
```
npm install
bundle install
```
You may need to run the following commands as well before.
```
sudo apt-get install libmariadb-dev
sudo apt install mysql-server
```

## Setup Database

Create the development database by running this :
```
rake db:create
rake db:migrate
rake db:seed
```
If this fails you may want to try this to fix your mysql configuration :
```
sudo mysql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '.u=Tb3kKL*';
```
You can replace the password after BY in the above command by any password you want, it just needs to correspond to the password provided in `config/local_env.yml`.

## Quickstart

Run this at the root of the project.
```
rails server
```