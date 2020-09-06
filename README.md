# Image Repository Challenge
The Following project is my Shopify Winter 2021 Developer Challenge Submission. The challenge can be found here: [Build an image repository](#https://docs.google.com/document/d/1ZKRywXQLZWOqVOHC4JkF3LqdpO3Llpfk_CkZPR8bjak/edit")
## Table of Contents
- [Introduction](#introduction)
- [Setup](#setup)
- [Operations](#operations)
  - [Queries](#queries)
  - [Mutations](#mutations)

## Introduction

For my solution to the Developer Intern Challenge, I have created an API for a theoretical platform called [INSERT NAME]. 

[LOGO HERE]


[INSERT NAME] is an E-commerce platform that lets users sell and purchase stock photography and images.

## Setup

[ RAILS + GraphQL + Postgres + Redis + Docker]

To setup and configure this application you can either configure it manually or use the provided dockerfile and `docker-compose.yml`.

This project was built using Ruby on Rails and will require you to have [Ruby 2.6.3](#https://www.ruby-lang.org/en/news/2019/04/17/ruby-2-6-3-released/) and [Ruby on Rails 6.0.3.2](#https://weblog.rubyonrails.org/2020/6/17/Rails-6-0-3-2-has-been-released/). Additionally you will need PostgreSQL and Redis installed.

Once you have installed the aforementioned technologies, clone this repo and modify `config/database-yml` to match your postgres username and password. 
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
- Go to `localhost:3000` and you should see 


[ RAILS Success Screen ]



