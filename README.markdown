# Clifton Studios

[![Build Status](https://travis-ci.org/kmcphillips/cliftonstudios.ca.png)](https://travis-ci.org/kmcphillips/cliftonstudios.ca)

[Kevin McPhillips](mailto:github@kevinmcphillips.ca)

[http://cliftonstudios.ca](http://cliftonstudios.ca)


## About

This is a Rails site for the Winnipeg Manitoba based artist co-op. I don't know why you'd want to set up your own copy of this website, but if you do for some reason here's how.


## Quick Setup

With an OS X or Linux machine with ruby and rubygems and bundler installed, you should be able to go from 0 to running in under three minutes.

### For the impatient

    $ git clone git://github.com/kmcphillips/cliftonstudios.ca.git
    $ cd cliftonstudios
    $ bin/setup
    $ bin/rails server

You'll need to create a MySQL database matching the credentials in the database.yml example file. After that, point your browser to [http://localhost:3000/](http://localhost:3000/) and you should be set to go.

### Get the source

Clone the git repo to get the source.

    $ git clone git://github.com/kmcphillips/cliftonstudios.ca.git

### Bundle and create config and everything

    $ bin/setup

Should do everything.

### Create a Database

Create the DB:

    $ cp config/database.yml.mysql config/database.yml
    $ mysql -u root -e "CREATE DATABASE cliftonstudios_development"
    $ mysql -u root -e "GRANT ALL PRIVILEGES ON cliftonstudios_development.* TO 'cliftonstudios'@'localhost' IDENTIFIED BY 'cliftonstudios'"
    $ mysql -u root -e "FLUSH PRIVILEGES"

### Done

Start the server and direct your browser to [http://localhost:3000/](http://localhost:3000/)

    $ bundle exec rails server

The admin area can be reached at [http://localhost:3000/admin/](http://localhost:3000/admin/) and the username and password that were created with the populate are test/test.


## Tests

There's a suite of spec tests for all models and helpers and some of the controllers. You'll need to create the test database.

    $ bundle exec rspec


## Feedback

Contact me at [github@kevinmcphillips.ca](mailto:github@kevinmcphillips.ca) with questions or feedback.
