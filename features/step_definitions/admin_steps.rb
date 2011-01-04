Then /^I should have (\d+) categories$/ do |arg1|
  Category.count.should == arg1.to_i
end

Given /^I have category$/ do
  Category.create(:name => "Category 0")
end

Then /^I should have (\d+) feeds$/ do |arg1|
  Feed.count.should == arg1.to_i
end

Then /^I should have some entries$/ do
  Entry.count.should > 0
end

Given /^I have feed$/ do
  Category.first.feeds.create(:title => "Feed 0", :accepted => true, :url => 'http://www.wp.pl/rss.xml?id=1')
end

Given /^I have nil accepted feed$/ do
  Category.first.feeds.create(:title => "Feed 0", :accepted => nil, :url => 'http://www.wp.pl/rss.xml?id=1')
end

Then /^I should have (\d+) accepted feeds$/ do |arg1|
  Feed.where(:accepted => true).count.should == arg1.to_i 
end
