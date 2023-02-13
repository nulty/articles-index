# Articles Index

It downloads a list of products and displays them in a HTML. The Project is build using Rails 7 and Ruby 3.2.0. 


The project was initialized with `rails new articles-index -c tailwind -d sqlite3`

# Running the application

1. Install Ruby. (I recommend using [asdf](https://github.com/asdf-vm/asdf))
2. Run `git clone https://github.com/nulty/articles-index.git`
3. Run `bundle`
4. Run `rails db:create db:migrate`
5. Start the server with `bin/dev`
6. Visit http://localhost:3000/articles

## Run Tests

`bin/rails test`

# Requirements

1. Fetch JSON Article data from endpoint.
2. JSON should refetch on every page load.
3. Display the article in a UI.
4. Allow user to 'like' an article in the UI.
5. Persist the like to a local datastore.

# Approach

The application has some major classes that handle the import and normalization of the data from the remote data source.

## Data

#### Download

When a request is made to retrieve the Articles, a `before_action` hook uses `Net::HTTP` to make a GET request to the remote datasource.

#### Importing
In order to allow users to persisit likes on the articles and also to update them when they change the application needs to persist the Articles the first time they are downloaded. The articles need to be updated if they have changed from the first time they were downloaded.

Each article has an `id` so we can use this as the way to identify unique articles from the remote data source. The data also has `created_at` and `updated_at` so we can tell when an article has changed.

When a new version of the file is downloaded and one of the persisted articles is updated, we will need to use a create or update approach. If the record does not exist in the local datastore then we create a new record. If the article id matches a record we have in the datastore we update the exitsing record.

Handling all this requires the implementation of a service class. The response from the data source is passed to the `ArticlesImporter`.

#### Normalising the data

The JSON has deep properties so a decision needs to be made about how to persist all the properties and whether they are all worth saving. For the purposes of this simple demonstration I think we can ignore many of the properties.

Many of the properties imply a relational structure at the source. User for example would have it's own relation. However, for this example we will save everything on one model. Database normalisation is not considered here.

Before the data can be saved to the local data store, some properties need to be normalised. The `ArticleMapping` class handles this.

#### Response
The imported articles are loaded from the database and returned in the original request response.


## Frontend

The page lists the title, description, photo, user avatar, user name and the number of likes the article has. 

The user can interact with the page by incrementing likes for particular articles.

#### Styling
The application uses [tailwindcss](https://tailwindcss.com/) to style the UI.

The UI uses flexbox and flexwrap to make the UI appear responsive. Not much effort has been spent on making the UI look amazing, however.

The `font-awesome-rails` gem is used to display a heart beside the likes count.

#### Behaviour
The only behaviour in the UI is allowing the User to click on an articles likes to increment the count of likes. 

This was implemented using [Stimulus](https://stimulus.hotwired.dev/). A `LikesController`.js handles the clicks and the HTML directives in the `index.html.erb`.


### Screenshot

![articles-screenshot](https://user-images.githubusercontent.com/556209/218525720-ba4f39a1-c06e-4137-9bee-eae62475e764.png)
