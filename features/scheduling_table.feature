Feature: editing schedule availability time slots

    As a Columbia student
    So that I can indicate the time I am available weekly to study,
    I want to edit a time table that shows my study availability.

Background: students in database

  Given the following students exist:
  | name   | email              | passcode    |
  | Frank  | frank@example.com  | frank789    |  

Scenario: User sets their available time slots
    Given the user is logged in
    Given the user visits the "profile" page
    When the user indicates their available time slots for each day
        | Day        | Available Time Slots               |
        | 1          | 9,10,11,12                         |
        | 2          | 9,10,11,12,13                      |
    When the user clicks the "Update" button
    Then the user's available time slots for the week are saved successfully

Scenario: User edits their available time slots
    Given the user is logged in
    Given the user visits the "profile" page
    Given the user has already set their available time slots for the week
    When the user indicates their available time slots for each day
        | Day     | Available Time Slots                  |
        | 3       | 13,14                                 |
        | 4       | 13,14,15                              |
    When the user clicks the "Update" button
    Then the user's available time slots for the week are updated successfully

Scenario: User clears their available time slots
    Given the user is logged in
    Given the user visits the "profile" page
    Given the user has already set their available time slots for the complete week
    And the user clears their available time slots for each day
    When the user clicks the "Update" button
    Then the user's available time slots for the week are cleared successfully
