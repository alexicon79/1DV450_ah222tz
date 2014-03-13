1DV450-ah222tz
==============

Alexander Hall [ah222tz] // Kurs: Webbramverk, Linnéuniversitetet

- - -

#TOERH
####The Open Education Resource Handler

TOERH is an API for open education resource handling. Users can request information about available resources, as well as filter resources by type, licence, owner, tags, etc. Only registered users may create, update and delete resources.

The API and its documentation is currently available at [http://alx-toerh.herokuapp.com/api/v1/](http://alx-toerh.herokuapp.com/api/v1/)

- - -

##LOCAL INSTALLATION

Start out with:

  bundle exec install

You will need to install a PostgreSQL database (for OS X users I can recommend [postgres.app](http://postgresapp.com/)) You can set the name of your database in config/database.yml

Then migrate databases:

  bundle exec rake db:migrate

Seed some data:

  bundle exec rake db:seed


Start the server:

  bundle exec rails server


Voila!
