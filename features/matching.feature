Feature: request to and accept / decline matches from potential study buddies' posts

    As a Columbia student
    So that I can have control over choosing and accepting my study buddies
    I want to make and accept / decline study buddy request matches.

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
      | 5          | Science | 15       | Tag8 | Text8    |


    And there are attendances with the following details:
      | student_id | post_id | apply_status |
      | 5          | 1       | pending      |
      | 5          | 2       | accepted     |
      | 4          | 2       | accepted     |
      | 1          | 3       | pending      |

Scenario: User sends a request to match with another student's post
    Given the user is logged in
    And the user visits the study group post page
    When the user clicks the "Request to Join" button
    Then the pending request should show up in the requestee's profile
    And the pending request should show up in the requested's post

Scenario: User attempts to request to match with their own post 
    Given the user is logged in 
    And the user visits a study group post page that they have created
    When the user clicks the "Request to Join" button
    Then the request should fail 
    And the user should see "You cannot request to join your own post"

Scenario: User attempts to request to match with a post they are already accepted in
    Given the user is logged in 
    And the user visits a study group post page that they are already accepted in
    When the user clicks the "Request to Join" button
    Then the request should fail 
    And the user should see "You have already applied to this post!"

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