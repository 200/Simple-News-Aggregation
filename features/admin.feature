Feature: Admin Panel
  In order to administrate
  As an admin
  I want to do all things

  Scenario: Create category
    Given I have no categories
    And I am on the panel page
    And I fill in "category_name" with "Category 0"
    And I press "category_submit"
    Then I should see "Category 0"
    And I should have 1 categories

  Scenario: Delete category
    Given I have category
    And I am on the panel page
    And I press "Delete"
    Then I should not see "Category 0"
    And I should have 0 categories

  Scenario: Add feed to category
    Given I have category
    And I am on the panel page
    And I fill in "feed_title" with "Feed 0"
    And I press "Add feed"
    Then I should see "Feed 0"
    And I should have category with 1 feeds

  Scenario: Delete feed from category
    Given I have category with 1 feeds
    And I am on the panel page
    And I follow "Delete"
    Then I should not see "Feed 0"
    And I should have category with 0 feeds

  Scenario: Accept feed proposal
    Given I have category with 1 not accepted feeds
    And I am on the panel page
    And I follow "Accept"
    Then I should see "Feed 0 Delete"
    And I should have category with 1 accepted feeds

  Scenario: Reject feed proposal
    Given I have category with 1 not accepted feeds
    And I am on the panel page
    And I follow "Reject"
    Then I should not see "Feed 0"
    And I should have category with 0 accepted feeds
