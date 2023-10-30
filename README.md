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

*\*If you are on macOS and run into the following error message: `ERROR: While executing gem ... (Gem::FilePermissionError) You don't have write permissions for the /Library/Ruby/Gems/2.X.X directory.`, then add `export PATH="$HOME/.rbenv/bin:$PATH"` and
`eval "$(rbenv init -)"` to your .bash_profile, restart your terminal, and then run the `gem install bundler` command.*

#### Database creation
  `rails db:create`
  
  `rails db:migrate`
  
  `rails db:seed`

#### Database checking
  `rails console`
  
  `ActiveRecord::Base.connection.tables` => ["schema_migrations", "ar_internal_metadata", "posts", "students", "student_attend_posts"]
  
  `Student.limit(10).all`
  
  `Student.count` => 5

#### Start server
  `rails server`

### Run Cucumber Feature Tests
  `rake cucumber`

  `cucumber features`

### Features
Assumptions:

- @username = "cs1234"; @password = "valid_password"; @firstname = "Christina"; @lastname = "Smith" is a valid authentication / account in our system (for testing purposes)

We will have the following paths / routes:
- login
- create_post
- home
- profile

