Feature: Create and manage users from admin interface

Scenario: New user
  Given a current season
  Given I am logged in as admin
  Given I am on the new admin user page
  When I fill in "Email" with "newguy@tff.org"
  And I fill in "Password" with "secret"
  And I fill in "Slots" with "10"
  And I press "Create"
  Then I find newguy@tff.org in Users
  And newguy@tff.org is not admin
  And I am on the admin users page

Scenario: New admin user
  Given I am logged in as admin
  Given I am on the new admin user page
  When I fill in "Email" with "newadmin@tff.org"
  And I fill in "Password" with "secret"
  And I check "make_admin"
  And I press "Create"
  Then I find newadmin@tff.org in Users
  And newadmin@tff.org is admin
  And I am on the admin users page

