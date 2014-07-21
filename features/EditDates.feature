Feature: Inspect and make changes to fishing dates

Background:
  Given a current season
  And I am logged in as admin
  And the following users exist:
  | email           | name       | password | slots | admin |
  | user1@gmail.com | John Doe   | abc123   | 8     | false |
  | user2@gmail.com | Jane Smith | abc123   | 8     | false |
  And the following dates exist:
  | date       | slots |
  | 2014-10-10 | 8     |
  | 2014-11-10 | 8     |
  | 2014-11-01 | 8     |
  And the following reservations exist:
  | date       | user            | guest  |
  | 2014-10-10 | user1@gmail.com |        |
  | 2014-10-10 | user1@gmail.com | Guest1 |
  | 2014-10-10 | user1@gmail.com | Guest2 |
  | 2014-11-01 | user2@gmail.com |        |
  | 2014-11-01 | user1@gmail.com |        |


Scenario: Add a new date
  Given I am on the admin date page for 2014-10-10
  And I follow "Make Reservation"
  And I choose user user2@gmail.com
  And I fill in "Slots" with "1"
  And I press "Submit"
  Then I should be on the new labels page for user2@gmail.com
  When I press "Submit"
  Then I should be on the admin date page for 2014-10-10
  And I should see "Jane Smith"

