Feature: User self-management

Background:
  Given a current season
  Given the following users exist:
    | email           | password  | admin |
    | bart@gmail.com  | abc123    | false |
    | lisa@peta.org   | donuts    | false |
  And bart@gmail.com is logged in with password "abc123"
  

Scenario: User show
  Then I should be on the User page for bart@gmail.com

Scenario: Cannot visit another user's page
  When I go to the User page for lisa@peta.org
  Then I should get a response with status 403

Scenario: User edit profile info
  When I go to the User page for bart@gmail.com
  And I press "Edit Profile"
  Then I should be on the User Edit page for bart@gmail.com
  And I can find "First name" field
  And I can find "Last name" field
  And I can find "Password" field
  And I can find "Password Confirm" field
  And I can find "Phone" field
  And I cannot find "Email" field
  And I cannot find "Slots" field

Scenario: Edit user
  Given I am on the User Edit page for bart@gmail.com
  And I fill in "First name" with "Napoleon"
  And I fill in "Last name" with "Supertramp"
  And I fill in "Phone" with "555-EAT-ACOW"
  And I press "Update"
  And test user is bart@gmail.com
  Then test user firstname should be "Napoleon"
  And test user lastname should be "Supertramp"
  And test user phone should be "555-EAT-ACOW"
  And user password should be "abc123"
  And I should be on the User page for bart@gmail.com


Scenario: Change user password
  Given I am on the User Edit page for bart@gmail.com
  When I fill in "Password" with "xyz"
  And I fill in "Password Confirm" with "xyz"
  And I press "Update"
  And test user is bart@gmail.com
  Then user password should be "xyz"

Scenario: Password confirm failuer
  Given I am on the User Edit page for bart@gmail.com
  When I fill in "Password" with "xyz"
  And I fill in "Password Confirm" with "xyx"
  And I press "Update"
  And test user is bart@gmail.com
  Then user password should be "abc123"
  And I should be on the User Edit page for bart@gmail.com
  And I should see "do not match"
