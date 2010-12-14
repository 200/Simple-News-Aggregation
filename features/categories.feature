Feature: Categories
  In order to manage categories
  As a user
  I want to check categories, categories feeds, categories entries

  @last_entries

  Scenario: Show all entries belongs to category paginated
    Given I have category
    And I have 1 feeds for category
    And I have 26 entries for feed
    And I am on the last entries
    Then I should not see "Feed 25"
