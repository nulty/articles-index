# Articles Index

It downloads a list of products and displays them in a HTML. The Project is build using Rails 7 and Ruby 3.2.0. 


The project was initialized with `rails new articles-index -c tailwind -d sqlite3`

# Getting Started

Start the server with `bin/dev`
Visit http://localhost:3000/articles

## Run Tests

`bin/rails test`

# Requirements

1. Fetch JSON Article data from endpoint.
2. JSON should refetch on every page load.
3. Display the article in a UI.
4. Allow user to 'like' an article in the UI.
5. Persist the like to a local datastore.

# Approach
### Data

In order to allow users to persisit likes on the articles and also to update them when they change the application needs to persist the articles the first time they are downloaded. Each article has an `id` so we can use this as the way to identify unique articles from the remote data source. The data also has `created_at` and `updated_at` so we can tell when an article has changed.

The JSON has deep properties so a decision needs to be made about how to persist all the properties and whether they are all worth saving. For the purposes of this simple demonstration I think we can ignore many of the properties. Many of the properties imply a relational structure at the source. User for example would have it's own relation. However, for this example we will save everything on one model. Database normalisation is not considered here.

When a new version of the file is downloaded and one of the persisted articles is updated, we will need to use a create or update approach. If the record does not exist in the local datastore then we create a new record. If the article id matches a record we have in the datastore we update the exitsing record.

```
rails g model Article original_id:integer title description:text location:json value:json original_created_at:datetime original_updated_at:datetime status:integer expiry:datetime reactions:json photos:json user:json
```

With the model created I can test the implementation. I can create a `articles.json` fixture and test that we can save each article to the datastore. One issue will be mapping the `id`, `created_at` and `updated_at` to original_*

### Frontend
I've never used tailwindcss so I'll use this for styling the articles index page.

The page will list the title, description, photo, user avatar, user name and the number of likes the article has. Once the UI is styled I will begin adding the frontend behavour of liking an article.
