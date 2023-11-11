Feature: editing schedule availability time slots

    As a Columbia student
    So that I can indicate the time I am available weekly to study,
    I want to edit a time table that shows my study availability.

Scenario: User sets their available time slots
    Given the user is on the profile page
    When the user indicates their available time slots for each day:
        | Day        | Available Time Slots                      |
        | Monday     | 9:00 AM - 12:00 PM, 1:00 PM - 5:00 PM     |
        | Tuesday    | 9:00 AM - 1:00 PM                         |
        | Wednesday  | 10:00 AM - 3:00 PM                        |
        | Thursday   | Not Available                             |
        | Friday     | 2:00 PM - 6:00 PM                         |
    And the user clicks on "Save Time Slots"
    Then the user's available time slots for the week are saved successfully

Scenario: User edits their available time slots
    Given the user has already set their available time slots for the week
    When the user toggles the following time slots:
        | Monday     | 12:00 PM - 1:00PM                         |
        | Wednesday  | 3:00 PM - 4:00PM                          |
        | Friday     | 3:00 PM - 5:00PM                          |
    And the user clicks on "Save Changes"
    Then the user's available time slots for the week are updated successfully
    And the user should see:
        | Day        | Available Time Slots                      |
        | Monday     | 9:00 AM - 5:00 PM                         |
        | Tuesday    | 9:00 AM - 1:00 PM                         |
        | Wednesday  | 10:00 AM - 4:00 PM                        |
        | Thursday   | Not Available                             |
        | Friday     | 2:00 PM - 3:00 PM, 5:00 PM - 6:00 PM      |

Scenario: User clears their available time slots
    Given the user has already set their available time slots for the week
    When the user selects the current week
    And the user clears their available time slots for each day
    And the user clicks on "Save Changes"
    Then the user's available time slots for the week are cleared successfully
