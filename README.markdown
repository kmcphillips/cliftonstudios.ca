# Clifton Studios

[Kevin McPhillips](mailto:github@kevinmcphillips.ca)

[http://cliftonstudios.ca](http://cliftonstudios.ca)


## About

This is a Rails 3 site for the Winnipeg Manitoba based artist co-op. I don't know why you'd want to set up your own copy of this website, but if you do for some reason here's how.

## Quick Setup

With an OS X or Linux machine with ruby and rubygems and bundler installed, you should be able to go from 0 to running in under three minutes. 

### For the impatient

    $ git clone git://github.com/kimos/cliftonstudios.ca.git
    $ cd cliftonstudios
    $ bundle install
    $ cp config/database.yml.example config/database.yml
    $ rake db:migrate
    $ rake db:populate
    $ rails server

You'll need to create a MySQL database matching the credentials in the database.yml example file. After that, point your browser to [http://localhost:3000/](http://localhost:3000/) and you should be set to go.

### Get the source

Clone the git repo to get the source.

    $ git clone git://github.com/kimos/cliftonstudios.ca.git

### Install the required gems

Bundler to the rescue!

    $ bundle install

The only tricky on is rmagick which depends on ImageMagick locally. On Linux it's usually just installing a package, but on OS X it's a little more intense.  

    $ sudo gem install haml will_paginate rmagick sqlite3-ruby

If rmagick won't install, then just comment it out from the Gemfile. The app will run but image uploads will not work. On linux you'll have to install the ImageMagick dev libraries that should be in the repo for your distro. On OS X try something like this:  

[http://github.com/masterkain/ImageMagick-sl](http://github.com/masterkain/ImageMagick-sl)


### Create a Database

Create the DB:

    $ cp config/database.yml.mysql config/database.yml
    $ mysql -u root -e "CREATE DATABASE cliftonstudios_development"
    $ mysql -u root -e "GRANT ALL PRIVILEGES ON cliftonstudios_development.* TO 'cliftonstudios'@'localhost' IDENTIFIED BY 'cliftonstudios'"
    $ mysql -u root -e "FLUSH PRIVILEGES"


### Create and populate the database

After the migrations, db:populate will seed required data, including a test user.

    $ rake db:migrate
    $ rake db:populate


### Done

Start the server and direct your browser to [http://localhost:3000/](http://localhost:3000/)

    $ rails server

The admin area can be reached at [http://localhost:3000/admin/](http://localhost:3000/admin/) and the username and password that were created with the populate are test/test.


## Tests

There's a suite of spec tests for all models and helpers and some of the controllers. You'll need to create the test database.

    $ mysql -u root -e "CREATE DATABASE cliftonstudios_test"
    $ mysql -u root -e "GRANT ALL PRIVILEGES ON cliftonstudios_test.* TO 'cliftonstudios'@'localhost' IDENTIFIED BY 'cliftonstudios'"
    $ mysql -u root -e "FLUSH PRIVILEGES"

Next, clone your current database into your test database.

    $ rake db:test:clone

Then run them!

    $ rake spec


## Feedback

Contact me at [github@kevinmcphillips.ca](mailto:github@kevinmcphillips.ca) with questions or feedback.
