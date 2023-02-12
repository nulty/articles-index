# Articles Index

It downloads a list of products and displays them in a HTML. The Project is build using Rails 7 and Ruby 3.2.0. 


The project was initialized with `rails new articles-index -c tailwind -d sqlite3`

# Getting Started

Start the server with `bin/rails s`

## Run Tests

`bin/rails test`

# Requirements

1. Fetch JSON Article data from endpoint.
2. JSON should refetch on every page load.
3. Display the article in a UI.
4. Allow user to 'like' an article in the UI.
5. Persist the like to a local datastore.
