Feature: create and delete post to search for new a study buddy

  As a Columbia student
  So that I can broadcast my need for a study buddy
  I want to create and delete a post requesting a study buddy for other students to see.

Scenario: User creates a new post
  Given the user is logged in
  Given the user visits the "new post" page
  And fills in the post details
  When the user clicks the "Create" button
  Then the post should be created successfully
  And the user should be directed to the "home" page

Scenario: User deletes a post from their profile
  Given the user is logged in
  And there exists a created post in the user's profile
  Given the user visits the "profile" page
  And selects the post to delete
  Then the user should be directed to the "specified post" page
  Then the post should be deleted from the user's profile

Scenario: User confirms a post from their profile when they have found a match
  Given the user is logged in
  And there exists a created post in the user's profile
  When the user visits the "profile" page
  And selects the post to confirm
  Then the user should be directed to the "profile" page
  Then the post should be confirmed successfully
