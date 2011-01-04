Then /^I should have (\d+) nil accepted feeds$/ do |arg1|
  Category.first.feeds.where(:accepted => nil).count.should == arg1.to_i 
end

