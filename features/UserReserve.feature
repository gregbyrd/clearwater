Feature: User can create a reservation for self

Background:
  Given the following seasons exist:
    | year | slots |
    | 2014 | 8     |
  And the following dates exist:
    | season | date       |
    | 2014   | 2014-10-10 |
  And the following users exist:
    | email               | password | admin | season | slots |
    | yogi@jellystone.gov | booboo   | false | 2014   | 1     |

Scenario: Route to reservation page
  Given yogi@jellystone.gov is logged in with password "booboo"
  When I follow "Make Reservation"
  Then I should be on the new reservation page for yogi@jellystone.gov

Scenario: Fulfill a reservation
  Given yogi@jellystone.gov is logged in with password "booboo"
  And I am on the new reservation page for yogi@jellystone.gov
  When I choose the date "2014-10-10"
  And fill in "Number of Slots" with "1"
  And press "Request"
  Then I should be on the new labels page for yogi@jellystone.gov
  When I press "Submit"
  Then I should be on the User page for yogi@jellystone.gov
  And I should see "Slots reserved: 1"


