Given /^I have (\d+) feeds for category$/ do |arg1|
  Feed.delete_all
  arg1.to_i.times do |num|
    Category.first.feeds.create(:title => "Feed #{num}")
  end 
end

Given /^I have entry for each of (\d+) feeds$/ do |arg1|
  arg1.to_i.times do |num|
    Feed.find_by_title("Feed #{num}").entries.create(:title => "Entry #{num}")
  end
end

Given /^I have (\d+) entries for feed$/ do |arg1|
  arg1.to_i.times do |num|
    Feed.first.entries.create(:title => "Entry #{num}")
  end
end

