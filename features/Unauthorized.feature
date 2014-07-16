
Feature: Unauthorized access

Scenario: Non-admin access to seasons list
  Given I am logged in as user
  When I go to the admin_seasons page
  Then I should get a response with status 403

