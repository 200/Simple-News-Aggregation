Feature: Admin Panel
  In order to administrate
  As an admin
  I want to do all things

  @category

  Scenario: Create category
    Given I am on the panel page
    And I fill in "category_name" with "Category 0"
    And I press "category_submit"
    Then I should see "Category 0"
    And I should see "Category has been successfully created."
    And I should have 1 categories

  Scenario: Create blank name Category
    Given I am on the panel page
    And I fill in "category_name" with ""
    And I press "category_submit"
    Then I should see "Name can't be blank"
    And I should have 0 categories

  Scenario: Create too long name Category
    Given I am on the panel page
    And I fill in "category_name" with "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    And I press "category_submit"
    Then I should see "Name is too long (maximum is 50 characters)"
    And I should have 0 categories

  Scenario: Create two categories with same name
    Given I am on the panel page
    And I fill in "category_name" with "Category 0"
    And I press "category_submit"
    Then I should see "Category 0"
    And I fill in "category_name" with "Category 0"
    And I press "category_submit"
    Then I should see "Name has already been taken"
    And I should have 1 categories
  
  Scenario: Delete category
    Given I have category
    And I am on the panel page
    And I should see "Category 0"
    And I press "Delete"
    Then I should not see "Category 0"
    And I should see "Category has been deleted."
    And I should have 0 categories

  @feed

  Scenario: Add feed to category
    Given I have category
    And I am on the panel page
    And I fill in "feed_url" with "http://www.wp.pl/rss.xml?id=1"
    And I press "Add feed"
    Then I should see "Wirtualna Polska"
    And I should see "Feed has been successfully added."
    And I should have 1 accepted feeds
    And I should have some entries

  Scenario: Add blank title feed to category
    Given I have category
    And I am on the panel page
    And I fill in "feed_url" with ""
    And I press "Add feed"
    Then I should see "Feed url is incorrent."
    And I should have 0 feeds

  Scenario: Add two same title feeds to category
    Given I have category
    And I am on the panel page
    And I fill in "feed_url" with "http://www.wp.pl/rss.xml?id=1"
    And I press "Add feed"
    And I fill in "feed_url" with "http://www.wp.pl/rss.xml?id=1"
    And I press "Add feed"
    Then I should see "Url has already been taken"
    And I should have 1 accepted feeds

  Scenario: Delete feed from category
    Given I have category
    And I have feed
    And I am on the panel page
    And I follow "Delete"
    Then I should not see "Feed 0"
    And I should see "Feed has been deleted."
    And I should have 0 feeds

  Scenario: Accept feed proposal
    Given I have category
    And I have nil accepted feed
    And I am on the panel page
    And I follow "Accept"
    Then I should see "Wirtualna Polska Delete"
    And I should see "Feed has been accepted." 
    And I should have 1 accepted feeds

  Scenario: Reject feed proposal
    Given I have category
    And I have nil accepted feed
    And I am on the panel page
    And I follow "Reject"
    Then I should see "Feed has been rejected."
    And I should have 0 feeds
