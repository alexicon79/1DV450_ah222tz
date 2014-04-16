1DV450-ah222tz
==============

Alexander Hall [ah222tz] // Kurs: Webbramverk, Linnéuniversitetet

- - -

#TOERH - CLIENT

NOTE: The API is currently NOT available online (due to trouble with Heroku). See instructions [here](https://github.com/alexicon79/1DV450_ah222tz/blob/master/README.md) for details on how to get the API up and running on a local machine.

- - -


##CLIENT INSTALLATION

Make sure the API-server is running locally and that you have seeded fresh data into the database. Then go to the root folder of the client application and run the following command to start the client server:
```
  scripts/web-server.js
```
You can now access the application through http://localhost:8000/app/index.html


##CHANGES TO THE API

- The biggest changes to the API have been made in the user model. I no longer store passwords locally on the server, but use Github OAuth for this instead.

- Authentication/authorization for users and applications/clients are now separate (APP-AUTH-TOKEN and USER-AUTH-TOKEN). Filters and validations for this have been customized.

- Several minor tweaks have been made to the JSON-output that is rendered.

- A new controller/endpoint for resource types has been added.

- Some minor bugs (properly adding tags to a resource, for example) have been fixed.

- Rack Middleware for handling Cross-Origin Resource Sharing (CORS) has been added.
