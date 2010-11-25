Feature: Admin Panel
  In order to administrate
  As an admin
  I want to do all things

  @category

  Scenario: Create category
    Given I have no categories
    And I am on the panel page
    Then I should see "Simple News Aggregation"
    And I fill in "category_name" with "Category 0"
    And I press "category_submit"
    Then I should see "Category 0"
    And I should see "Category has been successfully created."
    And I should have 1 categories

  Scenario: Create blank name Category
    Given I have no categories
    And I am on the panel page
    And I fill in "category_name" with ""
    And I press "category_submit"
    Then I should see "Name can't be blank"
    And I should have 0 categories

  Scenario: Create too long name Category
    Given I have no categories
    And I am on the panel page
    And I fill in "category_name" with "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    And I press "category_submit"
    Then I should see "Name is too long (maximum is 50 characters)"
    And I should have 0 categories

  Scenario: Create two categories with same name
    Given I have no categories
    And I am on the panel page
    And I fill in "category_name" with "Category 0"
    And I press "category_submit"
    And I fill in "category_name" with "Category 0"
    And I press "category_submit"
    Then I should see "Name has already been taken"
    And I should have 0 categories
  
  Scenario: Delete category
    Given I have category
    And I am on the panel page
    And I press "Delete"
    Then I should not see "Category 0"
    And I should see "Category has been deleted."
    And I should have 0 categories

  @feed

  Scenario: Add feed to category
    Given I have category
    And I am on the panel page
    And I fill in "feed_title" with "Feed 0"
    And I press "Add feed"
    Then I should see "Feed 0"
    And I should see "Feed has been successfully added."
    And I should have category with 1 feeds

  Scenario: Add blank title feed to category
    Given I have category
    And I am on the panel page
    And I fill in "feed_title" with ""
    And I press "Add feed"
    Then I should see "Title can't be blank"
    And I should have category with 0 feeds

  Scenario: Add to long title feed to category
    Given I have category
    And I am on the panel page
    And I fill in "feed_title" with "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    And I press "Add feed"
    Then I should see "Title is too long (maximum is 50 characters)"
    And I should have category with 0 feeds

  Scenario: Add two same title feeds to category
    Given I have category
    And I am on the panel page
    And I fill in "feed_title" with "Feed 0"
    And I press "Add feed"
    And I fill in "feed_title" with "Feed 0"
    And I press "Add feed"
    Then I should see "Title has already been taken"
    And I should have category with 0 feeds

  Scenario: Delete feed from category
    Given I have category with 1 feeds
    And I am on the panel page
    And I follow "Delete"
    Then I should not see "Feed 0"
    And I should see "Feed has been deleted."
    And I should have category with 0 feeds

  Scenario: Accept feed proposal
    Given I have category with 1 not accepted feeds
    And I am on the panel page
    And I follow "Accept"
    Then I should see "Feed 0 Delete"
    And I should see "Feed has been accepted." 
    And I should have category with 1 accepted feeds

  Scenario: Reject feed proposal
    Given I have category with 1 not accepted feeds
    And I am on the panel page
    And I follow "Reject"
    Then I should not see "Feed 0"
    And I should see "Feed has been rejected."
    And I should have category with 0 accepted feeds
