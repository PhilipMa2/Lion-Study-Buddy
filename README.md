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
