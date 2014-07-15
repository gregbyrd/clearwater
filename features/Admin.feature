Feature: Basic Administrative Tasks

Scenario: Access admin dashboard
  Given I am logged in as admin
  Then I should be on the Admin page
  And I should see "Seasons"
  And I should see "Users"
  And I should see "Dates"

