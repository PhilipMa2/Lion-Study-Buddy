Feature: request to and accept / decline matches from potential study buddies' posts

    As a Columbia student
    So that I can have control over choosing and accepting my study buddies
    I want to make and accept / decline study buddy request matches.

Scenario: User sends a request to match with another student's post
    Given the user is logged in 
    And the user visits the study group post page
    When the user presses "Request to Join"
    Then the pending request should show up in the requested's inbox
    And the pending request should show up in the requestee's profile
    And the button to join post should say "Pending"

Scenario: User attempts to request to match with their own post 
    Given the user is logged in 
    And the user visits a study group post page that they have created
    And the user presses "Request to Join"
    Then the request should fail 
    And the user should see "You cannot request to join your own post"

Scenario: User attempts to request to match with a post they are already accepted in
    Given the user is logged in 
    And the user visits a study group post page that they are already accepted in
    And the user presses "Request to Join"
    Then the request should fail 
    And the user should see "You are already in this study group"

Scenario: User accepts a request to match
    Given the user is logged in 
    And the user visits the profile page
    When the user accepts a match from their pending requests
    Then the match request should be gone from their pending requests
    And the requestee should have their pending request moved to matched requests 
    And the number of members in the post should increase by 1 

Scenario: User declines a request to match
    Given the user is logged in 
    And the user visits the profile page
    When the user declines a match from their pending requests
    Then the match request should be gone from their pending requests
    And the requestee should have their pending request removed 
    And the number of members in the post should increase by 0

