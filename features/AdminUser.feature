Feature: Create and manage users from admin interface

Background:
  Given a current season
  And I am logged in as admin
  And the following users exist:
    | email            | password | admin |
    | bart@gmail.com   | abc      | false |
  

Scenario: New user
  Given I am on the new admin user page
  When I fill in "Email" with "newguy@tff.org"
  And I fill in "Password" with "secret"
  And I fill in "Slots" with "10"
  And I press "Create"
  Then I find newguy@tff.org in Users
  And newguy@tff.org is not admin
  And I am on the admin users page

Scenario: New admin user
  Given I am on the new admin user page
  When I fill in "Email" with "newadmin@tff.org"
  And I fill in "Password" with "secret"
  And I check "make_admin"
  And I press "Create"
  Then I find newadmin@tff.org in Users
  And newadmin@tff.org is admin
  And I should be on the admin users page

Scenario: Edit user
  Given I am on the admin edit page for bart@gmail.com
  When I fill in "Slots" with "3"
  And I fill in "First name" with "Bart"
  And I fill in "Last name" with "Simpson"
  And I fill in "Phone" with "555-EAT-ACOW"
  And I press "Update"
  And test user is bart@gmail.com
  Then test user purchased should be 3
  And test user firstname should be "Bart"
  And test user lastname should be "Simpson"
  And test user phone should be "555-EAT-ACOW"
  And user password should be "abc"
  And I should be on the admin users page

Scenario: Change user password
  Given I am on the admin edit page for bart@gmail.com
  When I fill in "Password" with "xyz"
  And I press "Update"
  And test user is bart@gmail.com
  Then user password should be "xyz"
  And I should be on the admin users page

Scenario: Delete a user
  When I am on the admin users page
  And I follow the "Delete" link for user bart@gmail.com
  Then I do not find bart@gmail.com in Users  
  And I should be on the admin users page
  And I should see "User bart@gmail.com deleted."
