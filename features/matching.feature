Feature: request to and accept / decline matches from potential study buddies' posts

    As a Columbia student
    So that I can have control over choosing and accepting my study buddies
    I want to make and accept / decline study buddy request matches.

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
      | 2          | 1        | pending            |
      | 1          | 3        | accepted           |

Scenario: User sends a request to match with another student's post
    Given the user is logged in
    And the user visits the study group page 2
    When the user clicks the "Request to Join" button
    Then the pending request should show up in the requestee's profile
    And the pending request should show up in the requested's post

Scenario: User attempts to request to match with their own post 
    Given the user is logged in 
    And the user visits a study group post page that they have created
    When the user clicks the "Request to Join" button
    Then the request should fail 
    And the user should see "You cannot request to join your own group"

Scenario: User attempts to request to match with a post they are already accepted in
    Given the user is logged in 
    And the user visits a study group post page that they are already accepted in
    When the user clicks the "Request to Join" button
    Then the request should fail 
    And the user should see "You have already applied to this group!"

Scenario: User accepts a request to match
    Given the user is logged in 
    And the user visits a study group post page that they have created
    When the user clicks the "Accept" button
    Then the match request should be gone from their pending requests
    And the requestee should have their pending request moved to matched requests 
    And the number of members in the post should increase by 1 

Scenario: User declines a request to match
    Given the user is logged in 
    And the user visits a study group post page that they have created
    When the user clicks the "Reject" button
    Then the match request should be gone from their pending requests
    And the requestee should have their pending request removed 
    And the number of members in the post should increase by 0