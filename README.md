# Lion-Study-Buddy

### Group 28
Philip Ma (ym2876)
Angela Zhang (zz2921)
Kailun Zhang (kz2475)

### Instructions to Test and Run Product (Ruby version 3.2.2)

#### First, run these commands in order:
  `rbenv install 3.2.2`
  
  `rbenv local 3.2.2`
  
  `gem install bundler` *
  
  `bundle install`

*\*If you are on macOS and run into the following error message: `ERROR: While executing gem ... (Gem::FilePermissionError) You don't have write permissions for the /Library/Ruby/Gems/2.6.0 directory.`, then run `export GEM_HOME="$HOME/.gem"` before running the `gem install bundler` command.*

#### Database creation
  `rails db:create`
  
  `rails db:migrate`
  
  `rails db:seed`

#### Database checking
  `rails console`
  
  `ActiveRecord::Base.connection.tables`
  
  `Student.limit(10).all`
  
  `Student.count`

#### Start server
  `rails server`

### Features
Assumptions:

- @username = "cs1234"; @password = "valid_password"; @firstname = "Christina"; @lastname = "Smith" is a valid authentication / account in our system (for testing purposes)

We will have the following paths / routes:
- login
- create_post
- home
- profile

