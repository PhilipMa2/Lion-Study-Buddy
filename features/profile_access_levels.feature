Feature: restricting access to profile information based on access levels

    As a Columbia student
    So that I have my personally identifiable information (PII) like my email, full name, and schedule protected,
    I want to have PII available only to those I am currently matched in a study group with.

# Please refer to the README for details on the 3 access levels

# LEVEL 1 ACCESS:
Scenario: User accesses the profile of someone they have not matched with
    Given the user is logged in 
    And the user visits a non-matched user's profile page
    Then the user should see level 1 access information
    And the user should not see level 2 access information
    And the user should not see level 3 access information

Scenario: User accesses the profile of someone they have pending request, but not yet accepted
    Given the user is logged in 
    And the user visits a pending user's profile page
    Then the user should see level 1 access information
    And the user should not see level 2 access information
    And the user should not see level 3 access information

# LEVEL 2 ACCESS:
Scenario: User accesses the profile of someone they are currently in a study group with (open / full post)
    Given the user is logged in 
    And the user visits a matched user's profile page
    Then the user should see level 1 access information
    And the user should see level 2 access information
    And the user should not see level 3 access information

# LEVEL 3 ACCESS:
Scenario: User accesses their own profile
    Given the user is logged in 
    And the user visits the profile page
    Then the user should see level 1 access information
    And the user should see level 2 access information
    And the user should see level 3 access information
