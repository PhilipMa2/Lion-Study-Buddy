# Lion-Study-Buddy

### Group 28
Philip Ma (ym2876)
Angela Zhang (zz2921)
Kailun Zhang (kz2475)

### Instructions to Test and Run Product
[TODO]

### Features
Assumptions:

- @username = "cs1234"; @password = "valid_password"; @firstname = "Christina"; @lastname = "Smith" is a valid authentication / account in our system (for testing purposes)

We will have the following paths / routes:
- login
- create_post
- home
- profile
* Ruby version 3.2.2

* First Thing to do<br>
  rbenv install 3.2.2<br>
  rbenv local 3.2.2<br>
  gem install bundler<br>
  bundle install<br>

* Database creation<br>
  rails db:create<br>
  rails db:migrate<br>
  rails db:seed<br>

* Database checking<br>
  rails console<br>
  ActiveRecord::Base.connection.tables<br>
  Student.limit(10).all<br>
  Student.count<br>

* Start server<br>
  rails server<br>
