Feature: logging in and logging out

    As a Columbia student
    So that I can have my own profile
    I want to log in, log out, and do restricted actions only when I am logged in.

Scenario: User logs in successfully with valid credentials
    Given the user visits the "login" page
    When the user logs in with correct credentials
    Then the user should be logged in successfully

Scenario: User logs in unsuccessfully with invalid credentials
    Given the user visits the "login" page
    When the user logs in with wrong credentials
    Then the user should be directed to the "login" page

Scenario: User cannot access without valid credentials
    Given an unauthenticated user
    Given the user visits the "new post" page
    Then the user should be directed to the "login" page
    When the user logs in with correct credentials
    Then the user should be directed to the "home" page

Scenario: User can successfully log out
    Given the user visits the "login" page
    When the user logs in with correct credentials
    When the user clicks the "Logout" button
    Then the user should be logged out
    Then the user should be directed to the "home" page