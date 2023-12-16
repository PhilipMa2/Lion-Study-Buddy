Feature: create and delete group to search for new a study buddy

  As a Columbia student
  So that I can broadcast my need for a study buddy
  I want to create and delete a group requesting a study buddy for other students to see.

Background: students in database

  Given the following students exist:
  | name   | email              | passcode    |
  | Alice  | alice@columbia.edu | 123456      |  

  Given the following courses exist:
  | course_id  | course_name                    |
  | ACCTB8010  | Fundamental Analysis for Inves |

Scenario: User creates a new group
  Given the user is logged in
  Given the user visits the "new group" page
  And fills in the group details
  When the user clicks the "Create" button
  Then the group should be created successfully
  And the user should be directed to the "home" page

