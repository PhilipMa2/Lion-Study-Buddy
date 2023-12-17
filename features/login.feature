Feature: logging in and logging out

    As a Columbia student
    So that I can have my own profile
    I want to log in, log out, and do restricted actions only when I am logged in.

Background: students in database

  Given the following students exist:
  | name   | email              | passcode    |
  | Alice  | alice@columbia.edu  | 123456    |  

Scenario: User logs in unsuccessfully with invalid credentials
    Given the user visits the "login" page
    When the user logs in with wrong credentials
    Then the user should see "Invalid email or passcode"
    Then the user should be directed to the "login" page

Scenario: User cannot access without valid credentials
    Given an unauthenticated user
    Given the user visits the "new group" page
    Then the user should be directed to the "login" page
    When the user logs in with correct credentials
    Then the user should be directed to the "home" page
