
# Shoptography

<img src="/assets/documentation/logo.png">

**Shoptography is an E-commerce platform that lets users sell and purchase stock photography.**

The Following project is my <a href="https://docs.google.com/document/d/1ZKRywXQLZWOqVOHC4JkF3LqdpO3Llpfk_CkZPR8bjak/edit">Shopify Winter 2021 Developer Challenge Submission.</a>

## 📋 Table of Contents
- [Features](#-features)
- [Setup](#%EF%B8%8F-setup)
  - [Dependencies](#%EF%B8%8F-setup)
  - [Docker](#-docker-setup)
  - [API](#api-setup)
- [Schema](#schema)
- [API](#API)
  - [Design](#api-design)
  - [Queries](#queries)
  - [Mutations](#mutations)
- [Security](#security)
- [Search](#Search)
- [Linting](#linting)
- [Documentation](#linting)
- [Testing](#testing)

## 💻 Features

For my solution to the Developer Intern Challenge, I have created an API for a theoretical platform called Shoptography. The following is a list of features the platform supports:

* Users can signup or login using their desired email and password
* Users can upload, update, sell, and delete images
* Users can set and update an image's price
* Users cannot update or delete images they did not upload
* Users can search for images to purchase 
* Users can purchase images
* Users can set private viewing permissinons on their images
* Users can add tags to their images to improve their search visibility


## 🛠️ Setup

[ RAILS + GraphQL + Postgres + Redis + Docker]

To setup and configure this application you can either install the various dependencies as described below or use the provided dockerfile and `docker-compose.yml`. If you plan to use the Docker, skip to [Docker Setup](#docker-setup).

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

If you would like to run this app using docker, you will need to verify that the database host name, username, and password in `config/database.yml` match the information found in `docker-compose.yml` and that the host of the `redis_store` in `config/environments/development.rb` is titled 'redis'. 

The host name in `config/database.yml` should match the name of the postgres container ('db') and the host name of the redis_store should match the name of the redis container ('redis').

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

## 🗄️ Schema

[ IMG SCHEMA ]

* **User**: Represents someone who Interacts with the API
  * Relations
    * **Has Many**: Images
    * **Has Many**: Purchases
  * Attributes
    * **balance (float)**: Represents the user's currency balance
    * **email (string)**: Represents the user's email
    * **first_name (string)**: Represents the user's first name
    * **last_name (string)**: Represents the user's last name
    * **password_digest (string)**: Represents hashed version of the user's password

* **Image**: Represents an uploaded and purchasable Image
  * Relations
    * **Belongs To**: User (uploader/creator)
    * **Has Many**: Tags (Through ImageTags Join)
    * **Has One**: Active Storage Attachment (Image File)
  * Attributes
    * **description (text)**: Represents the image's description.
    * **price (float)**: Represents how much it costs for a User to purchase
    * **private (boolean)**: Represents whether the image is viewable by all users or only its creator
    * **title (string)**: Represents the images's title

* **ImageTag**: Join between Image and Tag for associating specific Images with a Tags that represent their characteristics
  * Relations
    * **Belongs To**: Image
    * **Belongs To**: Tag

* **Tag**: Represents a characteristic of another entity.
  * Relations
    * **Has Many**: ImageTags
    * **Has Many**: Images (Through ImageTags Join)
  * Attributes
    * **name (string)**: Represents the characteristic of a given tag

* **Purchase**: Represents a purchased image. When an Image is purchased, it's data is copied into a Purchase model to preserve the title, description, and most importantly the cost of the image at the time it was purchased. Users are allowed to freely update their existing uploaded images, and therefore this model was neccesary to ensure Users who have made purchases are not affected by Merchants making updates.
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

The Shoptography API is Built using GraphQL.

### API Design

[API ERD]

In designing this GraphQL API, I choose to follow the <a href="https://github.com/Shopify/graphql-design-tutorial/blob/master/TUTORIAL.md">guidelines</a> created by the Shopify API Patterns Team (<a href="https://youtu.be/2It9NofBWYg">Described in this 2018 GraphQL Conference talk by Leane Shapton</a>).

One of the Shopify API Patterns team's GraphQL guidelines is to <a href="https://youtu.be/2It9NofBWYg?t=329">Not expose implementation detail in your API design</a>. To follow this guideline, I abstracted out the ImageTags join table from Shoptography's domain model.

Additionally, to improve the performance of my API and remove multiple unnecessary round trips to datastores from nested GraphQL queries (<a href="https://engineering.shopify.com/blogs/engineering/solving-the-n-1-problem-for-graphql-through-batching/">the N+1 query problem</a>), I have have defined batch loaders using Shopify's <a href="https://github.com/Shopify/graphql-batch">GraphQL-Batch gem</a>. 

### Queries
**imageSearch:**<br>
A query that returns the results of a text based search for related images. The search algorithm is explained [here](#Search).

**profile:**<br>
A query that returns the profile of the currently logged in user.

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

## 🔍 Search

## 🧹 Linting

<img src="/assets/documentation/rubocop_logo.png" width="200px">

For this project I utilized RuboCop to enforce many of the guidelines outlined in the community <a href="https://rubystyle.guide/">Ruby Style Guide</a>. Additionally, I utilized the Shopify RuboCop config to implement the Shopify Ruby Style guidelines described <a href="https://shopify.github.io/ruby-style-guide/">here.</a>

```ruby
require: 
    - rubocop-rails
    - rubocop-faker
    - rubocop-rspec
inherit_gem:
    rubocop-shopify: rubocop.yml

```

## ✏️ Documentation

In addition to this readme, I have documented this project through inline comments and the API through GraphQL View Documentation.

[GRAPHQL EDITOR DOCUMENTATION IMAGE]

## 🧪 Testing

Several rspec tests have been written for this project including tests for:
* Model Validation
* GraphQL Types
* GraphQL Queries
* GraphQL mutations

Simply run:

```ruby
rspec
```

to run the test suite.