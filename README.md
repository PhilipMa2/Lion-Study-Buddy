# Lion-Study-Buddy

### Group 28
Philip Ma (ym2876)
Angela Zhang (zz2921)
Kailun Zhang (kz2475)

### Instructions to Test and Run Product
#### Ruby version 3.2.2

#### First things to do:
  rbenv install 3.2.2
  rbenv local 3.2.2
  gem install bundler
  bundle install

#### Database creation
  rails db:create
  rails db:migrate
  rails db:seed

#### Database checking
  rails console
  ActiveRecord::Base.connection.tables
  Student.limit(10).all
  Student.count

#### Start server
  rails server

### Features
Assumptions:

- @username = "cs1234"; @password = "valid_password"; @firstname = "Christina"; @lastname = "Smith" is a valid authentication / account in our system (for testing purposes)

We will have the following paths / routes:
- login
- create_post
- home
- profile

