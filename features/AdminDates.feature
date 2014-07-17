Feature: Create and manage dates from admin interface

Background:
  Given a current season
  And I am logged in as admin

Scenario: New date
  Given I am on the new admin date page
  And test day is a legal date
  When I specify date as test day
  And I fill in "Slots" with "5"
  And I press "Add Date"
  Then I should find test day in FishDates
  And slot limit for test day should be 5
  And I should be on the admin dates page

Scenario: Illegal date
  Given I am on the new admin date page
  And test day is a nonlegal date
  When I specify date as test day
  And I press "Add Date"
  Then I should not find test day in FishDates
  And I should be on the admin dates page

