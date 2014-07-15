Feature: User can login

Background:
  Given the following users exist:
    | email           | password  | admin |
    | abc@gmail.com   | abc123    | false |
    | admin@gmail.com | abc123    | true  |


Scenario: Login as user
  Given I am on the login page
  When I fill in the following:
    | Email    | abc@gmail.com |
    | Password | abc123        |
  And I press "Log in"
  Then I should be on the User page for abc@gmail.com


Scenario: Login as admin
  Given I am on the login page
  When I fill in the following:
    | email    | admin@gmail.com |
    | password | abc123          |
  And I press "Log in"
  Then I should be on the Admin page

