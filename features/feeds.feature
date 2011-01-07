Feature: Feeds
  In order to check feeds and send proposals
  As a user
  I want to check feeds, send proposal for new feed
  
  @proposal_feed_form

  Scenario Outline: Send feed proposal
    Given I have category
    And I am on <page> 
    And I fill in "feed_url" with "http://rss.cnn.com/rss/edition.rss"
    And I press "Add"
    Then I should see "Your proposal is waiting for admin acceptance."
    And I should have 1 nil accepted feeds
    Examples: Pages
      | page                      |
      | the category show         |
      | the category last entries |
   
  Scenario Outline: Send feed proposal with url that already exists in category
    Given I have category
    And I have feed
    And I am on <page> 
    And I fill in "feed_url" with "http://www.wp.pl/rss.xml?id=1"
    And I press "Add"
    Then I should see "Url"
    And I should have 0 nil accepted feeds
    Examples: Pages
      | page                      |
      | the category show         |
      | the category last entries |

  Scenario Outline: Send feed proposal with not corrent url
    Given I have category
    And I am on <page> 
    And I fill in "feed_url" with "<url>"
    And I press "Add"
    Then I should see "Feed url is incorrent."
    And I should have 0 nil accepted feeds
      | page                      | url   |
      | the category show         | 01234 |
      | the category last entries | 01234 |
      | the category show         | wp.pl |
      | the category last entries | wp.pl |
      | the category show         |       |
      | the category last entries |       |
