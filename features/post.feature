Feature: create and delete post to search for new a study buddy

  As a Columbia student
  So that I can broadcast my need for a study buddy
  I want to create and delete a post requesting a study buddy for other students to see.

Background: students in database

  Given the following students exist:
  | name   | email              | passcode    |
  | Frank  | frank@example.com  | frank789    |  

Scenario: User creates a new post
  Given the user is logged in
  Given the user visits the "new post" page
  And fills in the post details
  When the user clicks the "Create" button
  Then the post should be created successfully
  And the user should be directed to the "home" page

