Given /^I have no categories$/ do
  Category.delete_all
end

Then /^I should have (\d+) categories$/ do |arg1|
  Category.count == arg1.to_i
end

Given /^I have category$/ do
  Category.delete_all
  Category.create(:name => "Category 0")
end

Then /^I should have (\d+) feeds$/ do |arg1|
  Feed.count == arg1.to_i
end

Then /^I should have some entries$/ do
  Entry.count > 0
end

Given /^I have feed$/ do
  Category.first.feeds.create(:title => "Feed 0", :accepted => true, :url => 'test')
end

Given /^I have nil accepted feed$/ do
  Category.first.feeds.create(:title => "Feed 0", :accepted => nil, :url => 'test')
end

Then /^I should have (\d+) accepted feeds$/ do |arg1|
  Feed.where(:accepted => true).count == arg1.to_i 
end

Given /^I have not accepted feed$/ do
  Category.first.feeds.create(:title => "Feed 0", :url => 'test')
end


