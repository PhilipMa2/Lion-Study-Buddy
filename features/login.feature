Feature: logging in and logging out

    As a Columbia student
    So that I can have my own profile
    I want to log in, log out, and do restricted actions only when I am logged in.

Scenario: User logs in with valid credentials
    Given the user visits the login page
    When the user enters valid username and password
    And clicks the login button
    Then the user should be logged in successfully

Scenario: User cannot access without valid credentials
    Given an unauthenticated user
    Given the user visits the create_post page
    Then they should be directed to the login page
    When the user enters valid username and password
    And clicks the login button
    Then they should be redirected back to the restricted content

Scenario: User can successfully log out
    Given the user is on the login page
    When the user enters valid username and password
    And clicks the login button
    When the user clicks the logout button
    Then the user should be logged out
    Then the user should be redirected back to home