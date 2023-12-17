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
  `rails db:schema:load` OR `rails db:create` + `rails db:migrate`(must have migrate file)
  
  `rails db:seed`

#### Database checking
  `rails console`
  
  `ActiveRecord::Base.connection.tables` => ["courses", "students", "applications", "groups", "time_slots", "schema_migrations", "ar_internal_metadata"]
  
  `Student.limit(10).all`
  
  `Student.count` => 5

#### Start server
  `rails server`

### Run Cucumber Feature Tests
  `bundle exec rake cucumber` 

The code coverage is stored in coverage/cucumber and it is expected to be 91.8%

### Run Rspec Tests
  `bundle exec rake spec`

The code coverage is stored in coverage/rspec and it is expected to be 90.11%.

### New Features for iter2
* scheduling table feature
* post accepting/rejecting feature
* profile view accessibility feature

*A Note for Feature Tests*
These tests expect:
* "frank@example.com" email and "frank789" passcode to be the valid login for student with first name "Frank" in our database.
* Frank is unmatched with user Dave (id 4), who has an open post (id 4)


## Features

#### Log in
* students log in and out of their own account
* matching and requesting to match are only available after the student's identity has been verified through log in

#### Posts
* students create and delete posts requesting a study buddy for other students to see
* a post has the following information: 
  * status (open, full, or closed)
  * course
  * student count (# of matched students into the group... starts at 1)
  * capacity (max # of students the group will accept)
  * tag (optional text field)
  * text (optional text field)
* a user viewing the posts can also see the number of overlapping sessions between themselves and the accepted members of the study group
* a user viewing a post that has no overlapping sessions will have a warning flash

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
A student's privacy is protected based on the access level of the user accessing their profile. There are 3 access levels:
1. Non-matched user / guest [LEAST ACCESS]
2. Matched user [SOME ACCESS]
3. The user themselves [MOST ACCESS]

*Note*: The information accessible is cumulative by access level. In other words, a user with a higher access level can access everything someone with a lower access level can access, and more.

**ACCESS LEVEL 1**:
* User's first name
* User's bio (where they can disclose information they believe is relevant for potential study buddies to know)
* User's open posts

**ACCESS LEVEL 2**:
* User's last name
* User's email
* User's schedule availability visualized

**ACCESS LEVEL 3**:
* list of matched study groups (with names of members)
* list of incoming requests which they can accept or decline
* list of pending requests they have made
* list of past / closed study groups ie. from previous semesters
* editable access to their visualized schedule
* editable access to their personal bio text box
