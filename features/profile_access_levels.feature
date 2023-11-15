Feature: restricting access to profile information based on access levels

    As a Columbia student
    So that I have my personally identifiable information (PII) like my email, full name, and schedule protected,
    I want to have PII available only to those I am currently matched in a study group with.

# To be thorough with our check for access levels, the following scenario:
#   Cucumber will be logged in (id 5). For Frank, he should see:
#   Access level 1: Amy (1), Bob (2) -> Frank has pending / unaccepted request to Bob's post.
#   Access level 2: Cindy (3), Darren (4) -> Cindy has created a post. Frank, Cindy, and Darren are all accepted in it.
#   Access level 3: Frank viewing his own profile

Background:
    Given there are students with the following details:
      | email               | passcode | name    | course | schedule | tag   | text  |
      | amy@example.com     | 123456   | Amy     | Math   | Mon-Wed  | Tag1  | Text1 |
      | bob@example.com     | 654321   | Bob     | Science| Tue-Thu  | Tag2  | Text2 |
      | cindy@example.com   | 987654   | Cindy   | English| Mon-Fri  | Tag3  | Text3 |
      | darren@example.com  | 111222   | Darren  | History| Mon      | Tag4  | Text4 |
      | frank@example.com   | frank789 | Frank   | Physics| Fri      | Tag5  | Text5 |

    And there are posts with the following details:
      | creator_id | course  | capacity | tag  | text     |
      | 2          | Math    | 10       | Tag6 | Text6    |
      | 3          | Science | 15       | Tag7 | Text7    |

    And there are attendances with the following details:
      | student_id | post_id | apply_status |
      | 5          | 1       | pending      |
      | 5          | 2       | accepted     |
      | 4          | 2       | accepted     |

# Please refer to the README for details on the 3 access levels

# LEVEL 1 ACCESS:
Scenario: User accesses the profile of someone they have not matched with
    Given the user is logged in
    And the user visits user 1's profile page
    Then the user should see level 1 access information
    And the user should not see level 2 access information
    And the user should not see level 3 access information

Scenario: User accesses the profile of someone they have pending request, but not yet accepted
    Given the user is logged in
    And the user visits user 2's profile page
    Then the user should see level 1 access information
    And the user should not see level 2 access information
    And the user should not see level 3 access information

# LEVEL 2 ACCESS:
Scenario: User accesses the profile of creator who has accepted them into their study group post
    Given the user is logged in
    And the user visits user 3's profile page
    Then the user should see level 1 access information
    And the user should see level 2 access information
    And the user should not see level 3 access information

Scenario: User accesses the profile of someone they are currently in a study group with (open / full post)
    Given the user is logged in
    And the user visits user 4's profile page
    Then the user should see level 1 access information
    And the user should see level 2 access information
    And the user should not see level 3 access information

# LEVEL 3 ACCESS:
Scenario: User accesses their own profile
    Given the user is logged in
    And the user visits the "profile" page
    Then the user should see level 1 access information
    And the user should see level 2 access information
    And the user should see level 3 access information
