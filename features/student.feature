Feature: Student account management

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

Scenario: Creating a new student account successfully
    Given the user visits the "create account" page
    When I fill in the new account details with valid information
    When I click the "Create Account" button
      Then I should be redirected to the login page
      And I should see "Account successfully created. Please log in."

Scenario: Creating a student account with an existing email
    Given the user visits the "create account" page
    When I fill in the new account details with an existing email
    When I click the "Create Account" button
    Then I should see "An account with this email already exists. Please log in."

Scenario: Creating a student account with mismatching passwords
    Given the user visits the "create account" page
    When I fill in the new account details with mismatching passwords
    When I click the "Create Account" button
    Then I should see "Please make sure your password entries match."