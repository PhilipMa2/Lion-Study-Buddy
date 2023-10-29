Feature: create, edit, delete post to search for new a study buddy

  As a Columbia student
  So that I can broadcast my need for a study buddy
  I want to create, edit, and delete a post requesting a study buddy for other students to see.

Scenario: User creates a new post
  Given the user is logged in
  Given the user visits the "new post" page
  And fills in the post details
  When the user clicks the "submit" button
  Then the post should be created successfully
  And the user should be directed to the "home" page

Scenario: User deletes a post from their profile
  Given the user is logged in
  And there exists a post in the user's profile
  Given the user visits the "profile" page
  And selects the post to delete
  And confirms the deletion
  Then the user should be redirected back to "profile"
  Then the post should be deleted from the user's profile

Scenario: User edits a post from their profile
  Given the user is logged in
  And there exists a post in the user's profile
  When the user visits the "profile" page
  And selects the post to edit
  And updates the post details
  When the user clicks the "save" button
  Then the user should be directed to the "profile" page
  Then the post should be edited successfully
