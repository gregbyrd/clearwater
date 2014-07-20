
Feature: Unauthorized access

Scenario: Non-admin access to seasons list
  Given I am logged in as user
  When I go to the admin_seasons page
  Then I should get a response with status 403

Scenario: Non-admin access to admin page
  Given I am logged in as user
  When I go to the admin page
  Then I should get a response with status 403

Scenario: User access to the wrong user page
  Given a current season
  Given the following users exist:
  | email   | password  | admin | 
  | a@b.com | abc       | false |
  | x@y.com | abc       | false |
  And a@b.com is logged in with password "abc"
  When I go to the User page for x@y.com
  Then I should get a response with status 403

Scenario: User access to the wrong reservations page
  Given a current season
  Given the following users exist:
  | email   | password  | admin | 
  | a@b.com | abc       | false |
  | x@y.com | abc       | false |
  And a@b.com is logged in with password "abc"
  When I go to the new reservation page for x@y.com
  Then I should get a response with status 403
