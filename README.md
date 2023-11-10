# Lion-Study-Buddy

A specialized platform designed for Columbia University students to discover study session partners and integrate a detailed schedule planner within each student's profile.

### Created by Group 28
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
  `bundle exec rake cucumber` 

The code coverage is stored in coverage/cucumber and it is expected to be 96.77%

### Run Rspec Tests
  `bundle exec rake spec`

The code coverage is stored in coverage/rspec and it is expected to be 97.85%.

### Basic Features (iter1)
* login, logout feature 
* post feature (create, delete, confirm)

*TODO for iter2:* 
* matching students

*A Note for Feature Tests*
These tests expect "frank@example.com" email and "frank789" passcode to be the valid login for student with first name "Frank" in our database.


## Features

#### Log in
* students log in and out of their own account
* matching and requesting to match are only available after the student's identity has been verified through log in

#### Posts
* students create and delete posts requesting a study buddy for other students to see
* students indicate the course, frequency of study, number of students in group, and optionally a tag or short written description of focuses of the study group

#### Post Filtering & Sorting
* students are able to filter all open posts by course name
* students are able to sort posts by number of overlapping times with their own schedule

#### Matching - 2-way response to posts
* students request to match with a post by clicking on a post and pressing "Request to Match"
* students have the option to accept or decline people who request to match in their profile
* if a student is on a post that does not match their availability, there should be a flash warning
* students cannot request to match their own post
* students are matched iff both parties have approved of the match

#### Profile
* students have their own customizable profiles, where they can disclose information they believe is relevant for potential study buddies to know
* students indicate their availabilities for study via the schedule visualizer
* students' privacy is protected based on the access level (ie. match status) of the user viewing their profile. In other words, sensitive information like email and last name will not be disclosed until both parties have agreed to match.