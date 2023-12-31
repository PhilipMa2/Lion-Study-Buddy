Feature: restricting access to profile information based on access levels

    As a Columbia student
    So that I have my personally identifiable information (PII) like my email, full name, and schedule protected,
    I want to have PII available only to those I am currently matched in a study group with.

# To be thorough with our check for access levels, the following scenario:
#   Cucumber will be logged in (id 1). For Alice, she should see:
#   Access level 1: Bob (2) -> Alice has pending / unaccepted request to Bob's post.
#   Access level 2: Carol (3), Dave (4) -> Carol has created a post. Alice, Carol, and Dave are all accepted in it.
#   Access level 3: Alice viewing her own profile

Background:
    Given there are students with the following details:
      | email                | passcode | name    |  text  |
      | alice@columbia.edu   | 123456   | Alice   |  text  |
      | bob@columbia.edu     | 123456   | Bob     |  text  |
      | carol@columbia.edu   | 123456   | Carol   |  text  |
      | dave@columbia.edu    | 123456   | Dave    |  text  |
      | frank@columbia.edu   | 123456   | Frank   |  text  |

    And there are groups with the following details:
      | creator_id | course                            | capacity | focus       | text     |
      | 1          | Fundamental Analysis for Inves    | 10       | analysis    | Text6    |
      | 2          | Contemporary Latin American Art   | 15       | art         | Text7    |
      | 3          | SUPERVISED PROJ PHOTOGRAPHY       | 15       | photography | Text8    |

    And there are attendances with the following details:
      | student_id | group_id | application_status |
      | 1          | 2        | pending            |
      | 1          | 3        | accepted           |
      | 4          | 3        | accepted           |

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
