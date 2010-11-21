Given /^I have no categories$/ do
  Category.delete_all
end

Then /^I should have (\d+) categories$/ do |arg1|
  Category.count == arg1.to_i
end

Given /^I have category$/ do
  Category.delete_all
  Category.create!(:name => "Category 0")
end

Then /^I should have category with (\d+) feeds$/ do |arg1|
  Category.first.feeds.count == arg1.to_i
end

Given /^I have category with (\d+) feeds$/ do |arg1|
  Category.delete_all
  cat = Category.create!(:name => "Category 0")
  arg1.to_i.times do |i|
    Feed.create!(:title => "Feed #{i}", :category_id => cat.id, :accepted => true)
  end
end

Given /^I have category with (\d+) not accepted feeds$/ do |arg1|
  Category.delete_all
  cat = Category.create!(:name => "Category 1")
  arg1.to_i.times do |i|
    Feed.create!(:title => "Feed #{i}", :category_id => cat.id)
  end
end

Then /^I should have category with (\d+) accepted feeds$/ do |arg1|
  Category.first.feeds.where(:accepted => true).count == arg1.to_i
end



