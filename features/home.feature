Feature: Home page group listing and filtering

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

Scenario: Viewing all groups without filters
    When I visit the home page
    Then I should see all the groups

Scenario: Filtering groups by capacity
    When I visit the home page
    And I fill in "capacity" with "10"
    And I press "Search"
    Then I should see groups with a capacity of 10 or less

Scenario: Filtering groups by course search
    When I visit the home page
    And I fill in "course_search" with "analysis"
    And I press "Search"
    Then I should see groups related to "analysis"
