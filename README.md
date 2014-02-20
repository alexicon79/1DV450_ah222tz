1DV450-ah222tz
==============

Alexander Hall [ah222tz] // Kurs: Webbramverk, Linnéuniversitetet

- - -

#TOERH
####The Open Education Resource Handler

TOERH is an API for open education resource handling. Users can request information about available resources, as well as filter resources by type, licence, owner, tags, etc. Only registered users may create, update and delete resources.

The API and its documentation is currently available at [http://alx-toerh.herokuapp.com/api/v1/](http://alx-toerh.herokuapp.com/api/v1/)

In order to access the API you must first register to receive a valid API-key.

##API-key registration

1. Go to http://alx-toerh.herokuapp.com/register
2. Enter a valid contact email address.
3. Copy your generated API-key and store it in a safe place.

##Authorization

Attach your API-key to the HTTP-header in this format:

```

Authorization: Token token="257b082c2d0c1c10ff34ee0ec6ad803d"

```

(Remember to change the example token above to your actual key)

###Access to create, update, delete

Only registered users (not the same as having a valid API-key) are allowed to create, update and delete resources. In order to do identify yourself you need to fill in valid credentials (Basic HTTP Authentication) when performing actions requiring authorization.

There is a demo user account if you want to try this out:

```

  Username: guest
  Password: guest

```

TIP: Postman (Chrome plugin) is a highly recommended service for trying out the API in different ways. It supports sending required headers and has a simple and intuitive interface.

## Using the API

### Formats
The API supports JSON and XML, with JSON being the standard (and recommended) format. To get data as XML just append .xml to the url.

###Endpoints

[http://alx-toerh.herokuapp.com/api/v1/resources](http://alx-toerh.herokuapp.com/api/v1/resources) - get available resources (default - allows filtering).
[http://alx-toerh.herokuapp.com/api/v1/users](http://alx-toerh.herokuapp.com/api/v1/users) - get available users.
[http://alx-toerh.herokuapp.com/api/v1/tags](http://alx-toerh.herokuapp.com/api/v1/tags) - get available tags.
[http://alx-toerh.herokuapp.com/api/v1/licences](http://alx-toerh.herokuapp.com/api/v1/licences) - get available licences.

###REST in peace

To get resource with id 3, you can simply write:

```

.../resources/3

```

To get all resources belonging to user with id 3 (and don't want to use filters), you can access the API through the users endpoint and add "resources" after the id:

```

.../users/3/resources

```


Similar url structure is applied for licences and tags:

```

...licences/3/resources
.../tags/3/resources

```

###Filtering
(Only available through the resources endpoint)

You can filter resources by licence, type, tag (by either id or string) and user (only id). To allow filtering you just append "?filter=true" to the url, and then pass your parameters. Like so:

```

.../resources?filter=true&parameter=value

```


####Examples:

Get all resources with MIT licence:

```

.../resources?filter=true&licence=mit

```


Get all resources with tag "happy":

```

.../resources?filter=true&tag=happy

```


Get first video-type resource with an GNU licence, with the tag "est", by user with id nr. 4 (currently, users can only be filtered by id):

```

.../resources?filter=true&type=video&licence=GNU&tag=est&user=4

```


### Offset and limit

You can limit the amount of results by passing a limit parameter:

```

.../resources?limit=3

```


You can also limit your filtered results:

```

.../resources?filter=true&user=2&limit=2

```


To set an offset to your limited results just pass an offset parameter:

```

.../resources?limit=10&offset=5

```


### Create or update - parameters

The parameters that need to be included when creating (POST) or updating (PUT) a resource through the API are:

```

#  resource_type_id      :integer
#  licence_id            :integer
#  user_id               :integer
#  name                  :string (max 60 characters)
#  description           :string (max 255 characters)
#  url                   :string
#  tag[]                 :string (optional, must include [] if more than one tag)

```

User:

```

#  firstname             :string
#  lastname              :string
#  email                 :string
#  username              :string (min 3, max 25 characters)
#  password              :string (min 5 characters)
#  password_confirmation :string (min 5 characters)

```

Tag:

```

#  tag_name              :string

```

Licence:

```

#  licence_type          :string

```
