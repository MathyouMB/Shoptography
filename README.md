
# Shoptography

<img src="/assets/documentation/logo.png">

**Shoptography is an E-commerce platform that lets users sell and purchase stock photography.**

The following project is my <a href="https://docs.google.com/document/d/1ZKRywXQLZWOqVOHC4JkF3LqdpO3Llpfk_CkZPR8bjak/edit">Shopify Winter 2021 Developer Challenge Submission.</a>

## 📋 Table of Contents
- [Features](#-features)
- [Setup](#%EF%B8%8F-setup)
  - [Dependencies](#%EF%B8%8F-setup)
  - [Docker](#-docker-setup)
  - [API](#api-setup)
- [Schema](#schema)
- [API](#%EF%B8%8F-api)
  - [Design](#api-design)
  - [Queries](#queries)
  - [Mutations](#mutations)
- [Security](#-security)
- [Search](#-search)
- [Linting](#-linting)
- [Documentation](#%EF%B8%8F-documentation)
- [Testing](#-testing)

## 💻 Features

For my solution to the Developer Intern Challenge, I have created an API for a theoretical platform called Shoptography. The following is a list of features the platform supports:

* Users can signup or login using their desired email and password
* Users can upload, update, sell, and delete images
* Users can set and update an image's price
* Users cannot update or delete images they did not upload
* Users can search for images to purchase 
* Users can purchase images
* Users can set private viewing permissions on their images
* Users can add tags to their images to improve their search visibility


## 🛠️ Setup

<img src="/assets/documentation/setup_logos.png" width="400px">

To set up and configure this application, you can either install the various dependencies as described below or use the provided dockerfile and `docker-compose.yml`. If you plan to use the Docker, skip to [Docker Setup](#-docker-setup).

This project was built using Ruby on Rails and will require you to have <a href="https://www.ruby-lang.org/en/news/2019/04/17/ruby-2-6-3-released/">Ruby 2.6.3</a> and <a href="https://weblog.rubyonrails.org/2020/6/17/Rails-6-0-3-2-has-been-released/">Ruby on Rails 6.0.3.2</a>. Additionally you will need PostgreSQL and Redis installed.

Once you have installed the aforementioned technologies, clone this repo and modify `config/database.yml` to match your local PostgreSQL credentials. 
```ruby
development:
  <<: *default
  database: image_repository_development
  username: YOUR_USERNAME
  password: YOUR_PASSWORD

test:
  <<: *default
  database: image_repository_test
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

You will may also need to modify `config/environments/development.rb` and `config/environments/test.rb` to configure redis. 

```ruby
  config.cache_store = :redis_store, {
    host: 'redis', # Should be 'localhost' if not using docker-compose setup
    port: 6379,
    db: 0,
    namespace: 'cache',
  }, {
    expires_in: 90.minutes,
  }
```

After you've properly configured PostgreSQL and Redis run the following commands:
- run `bundle` to install all ruby gems related to the project
- run `rake db:migrate` and `rake db:seed` to migrate the database and seed it with data
- run `rails s` or `rails server`
- View `localhost:3000` and you should see 


<img src="/assets/documentation/rails_success.png">

## 🐳 Docker Setup

<img src="/assets/documentation/docker_logo.png" width="200px">

If you would like to run this app using docker, you will need to verify that the database host name, username, and password in `config/database.yml` match the information found in `docker-compose.yml` 'db' container and that the `redis_store` information in `config/environments/development.rb` matches the information in the 'redis' container. 

The host name in `config/database.yml` should match the name of the postgres container ('db') and the host name of the redis_store should match the name of the redis container ('redis').

```ruby
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  #host: db #uncomment this if using docker-compose

development:
  <<: *default
  database: image_repository_development
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

```ruby
db:
    image: postgres:12-alpine
    environment: 
        POSTGRES_USER: YOUR_USERNAME
        POSTGRES_PASSWORD: YOUR_PASSWORD
    networks:
        - imagerepo
```

Once you've verified all the connections with postgres and redis should be properly configured, run:

```bash
docker-compose up
```

## API Setup

<img src="/assets/documentation/altair_logo.png" width="200px">

For using this API, I strongly recommend <a href="https://altair.sirmuel.design/">Altair GraphQL Client</a>. Altair is capable of seamlessly using files as GraphQL parameters and can dynamically generate the body of your GraphQL requests.

The GraphQL API can be utilized using POST `http://localhost:3000/graphql`.

Many of the GraphQL operations will require you to be logged in and submit a valid JWT Token via the `Authentication` header. You can retrieve your JWT Token using the `login` mutation.

You can log in using the credentials:
* **Email**: tester@email.com
* **Password**: tester

<img src="/assets/documentation/screen_login.png" width="600px">

Add the `Authentication` Header:

<img src="/assets/documentation/screen_auth.png" width="600px">

If you do not have a valid JWT token in the Authentication header on specific operations, you will receive this error:

<img src="/assets/documentation/screen_fail.png" width="600px">

## Schema

<img src="/assets/documentation/schema_diagram.png" width="600px">

**NOTE:** To store images, I utilized Rails Active Storage. Active Storage uses polymorphic associations. These are represented above using dotted lines.

* **User**: Represents someone who Interacts with the API
  * Relations
    * **Has Many**: Images
    * **Has Many**: Purchases
  * Attributes
    * **balance (float)**: Represents the user's currency balance
    * **email (string)**: Represents the user's email
    * **first_name (string)**: Represents the user's first name
    * **last_name (string)**: Represents the user's last name
    * **password_digest (string)**: Represents the hashed version of the user's password

* **Image**: Represents an uploaded and purchasable image
  * Relations
    * **Belongs To**: User (uploader/creator)
    * **Has Many**: Tags (Through ImageTags Join)
    * **Has One**: Active Storage Attachment (Image File)
  * Attributes
    * **description (text)**: Represents the image's description.
    * **price (float)**: Represents how much it costs for a user to purchase
    * **private (boolean)**: Represents whether the image is viewable by all users or only its creator
    * **title (string)**: Represents the image's title

* **ImageTag**: Join between mage and Tag for associating specific images with a tags that represent their characteristics
  * Relations
    * **Belongs To**: Image
    * **Belongs To**: Tag

* **Tag**: Represents a characteristic of another entity.
  * Relations
    * **Has Many**: ImageTags
    * **Has Many**: Images (Through ImageTags Join)
  * Attributes
    * **name (string)**: Represents the characteristic of a given tag

* **Purchase**: Represents a purchased image. When an image is purchased, it's data is copied into a purchase model to preserve the title, description, and most importantly the cost of the image at the time it was purchased. Users are allowed to freely update their existing uploaded images, and therefore this model was necessary to ensure users who have made purchases are not affected by Merchants making updates.
  * Relations
    * **Belongs To**: User (The User who Purchased the Image)
    * **Belongs To**: Merchant (The User who uploaded and sold this Image)
    * **Has One**: Active Storage Attachment (Image File)
  * Attributes
    * **description (text)**: Represents the image's description.
    * **cost (float)**: Represents how much it costed the User to purchase
    * **title (string)**: Represents the images's title

## ☁️ API

<img src="/assets/documentation/graphql_logo.png" width="200px">

The Shoptography API is built using GraphQL.

### API Design

In designing this GraphQL API, I choose to follow the <a href="https://github.com/Shopify/graphql-design-tutorial/blob/master/TUTORIAL.md">guidelines</a> created by the Shopify API Patterns Team (<a href="https://youtu.be/2It9NofBWYg">Described in this 2018 GraphQL Conference talk by Leane Shapton</a>).

One of the Shopify API Patterns team's GraphQL guidelines is to <a href="https://youtu.be/2It9NofBWYg?t=329">Not expose implementation detail in your API design</a>. To follow this guideline, I abstracted out the ImageTags join table from Shoptography's domain model.

Additionally, to improve the performance of my API and remove multiple unnecessary round trips to datastores from nested GraphQL queries (<a href="https://engineering.shopify.com/blogs/engineering/solving-the-n-1-problem-for-graphql-through-batching/">the N+1 query problem</a>), I have defined batch loaders using Shopify's <a href="https://github.com/Shopify/graphql-batch">GraphQL-Batch gem</a>. 

<img src="/assets/documentation/erd_diagram.png" width="600px">

### Queries

**image:**<br>
A query that returns the information of a specified image.

**imageSearch:**<br>
A query that returns the results of a text-based search for related images. The search algorithm is explained [here](#-search).

**profile:**<br>
A query that returns the profile of the currently logged in user.

**purchase:**<br>
A query that returns the information of a specified purchase.

**user:**<br>
A query that returns the profile of the specified user.

### Mutations
**addImageTag:**<br>
A mutation that adds a Tag to a given Image using the provided tag name.

**createImage:** (upload image)<br>
A mutation that creates an Image Entity using the provided information.

**createPurchase:** (purchase image)<br>
A mutation that creates a Purchase entity for the image given with the provided id for the currently logged in user 

**deleteImage:**<br>
A mutation that deletes the Image with the provided id.

**login:**<br>
A mutation that logs in the user of the provided email and returns a JWT Token.

**signUp:**<br>
A mutation that creates a new user using the provided information.

**updateImage**<br>
A mutation that updates the image of the provided id

**updateUser**<br>
A mutation that updates the current user using the provided information

## 🔐 Security

All available GraphQL operations have error handling to prevent any internal errors from being exposed to users.

To verify a user's identity, the API uses JWT tokens. A user can receive their JWT Token by using the `login` mutation.

Additionally, all user passwords are hashed using Bcrypt.

## 🔍 Search

Users can search using the <b>imageSearch</b> GraphQL query to do a text-based search over all <b>public</b> images in the database.

```ruby
def resolve(search_input:)
    images = ::Image.public_images
    results = []
    images.each do |i|
      results << i if i.search_string.downcase.include?(search_input.downcase)
    end
    results
 end
```

The search shown above utilizes a method called `search_string` to determine what should be returned based on the given `search_input`.

```ruby
def search_string
    Rails.cache.fetch([cache_key, __method__]) do
      s = title + ' ' + description + ' '
      s + tags.map(&:name).join(', ')
    end
end
```

`search_input` is the aggregation of an image's title, description, and tags. To prevent having to do this aggregation several times, `search_input` is cached in redis.


## 🧹 Linting

<img src="/assets/documentation/rubocop_logo.png" width="200px">

For this project, I utilized RuboCop to enforce many guidelines outlined in the community <a href="https://rubystyle.guide/">Ruby Style Guide</a>. Additionally, I utilized the Shopify RuboCop config to implement the Shopify Ruby Style guidelines described <a href="https://shopify.github.io/ruby-style-guide/">here.</a>

```ruby
require: 
    - rubocop-rails
    - rubocop-faker
    - rubocop-rspec
inherit_gem:
    rubocop-shopify: rubocop.yml

```

## ✏️ Documentation

In addition to this readme, I have documented this project through inline comments and GraphQL client documentation.

<img src="/assets/documentation/screen_docs.png" width="500px">

## 🧪 Testing

Several rspec tests have been written for this project, including tests for:
* Model Validation
* GraphQL Queries
* GraphQL mutations

Simply run:

```ruby
rspec
```

to run all provided tests.