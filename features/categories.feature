Feature: Categories
  In order to manage categories
  As a user
  I want to check categories, categories feeds, categories entries

  @index

  Scenario: Show category and 5 last feeds belongs to this  category
    Given I have category
    And I have 6 feeds for category
    And I have entry for each of 6 feeds
    And I am on the categories index
    Then I should see "Category 0"
    And I should see "Feed 5"
    And I should see "Feed 4"
    And I should see "Feed 3"
    And I should see "Feed 2"
    And I should see "Feed 1"

  @show

  Scenario: Show all feeds belongs to category and 5 last entries belongs to each of feeds
    Given I have category
    And I have 1 feeds for category
    And I have 6 entries for feed
    And I am on the category show
    Then I should see "Category 0"
    And I should see "Feed 0"
    And I should see "Entry 5"
    And I should see "Entry 4"
    And I should see "Entry 3"
    And I should see "Entry 2"
    And I should see "Entry 1"
  
  @last_entries

  Scenario: Show all entries belongs to category paginated
    Given I have category
    And I have 1 feeds for category
    And I have 26 entries for feed
    And I am on the last entries
    Then I should not see "Feed 25"
