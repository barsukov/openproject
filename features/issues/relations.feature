Feature: Relating issues to each other

  Background:
    Given there is 1 user with the following:
      | login | bob |
    And there is a role "member"
    And the role "member" may have the following rights:
      | view_issues   |
    And there is 1 project with the following:
      | name       | project1 |
      | identifier | project1 |
    And the project "project1" has the following trackers:
      | name | position |
      | Bug  |     1    |
    And the user "bob" is a "member" in the project "project1"
    And the user "bob" has 1 issue with the following:
      | subject | Some Issue |
    And the user "bob" has 1 issue with the following:
      | subject | Another Issue |
    And I am logged in as "admin"

  @javascript
  Scenario: Adding a relation will add it to the list of related issues through AJAX instantly
    When I go to the page of the issue "Some Issue"
    And I click on "Add related issue"
    And I fill in "relation_issue_to_id" with "2"
    And I press "Add"
    And I wait for the AJAX requests to finish
    Then I should be on the page of the issue "Some Issue"
    And I should see "related to Bug #2: Another Issue"
