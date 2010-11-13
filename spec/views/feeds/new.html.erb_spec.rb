require 'spec_helper'

describe "feeds/new.html.erb" do
  before(:each) do
    assign(:feed, stub_model(Feed,
      :url => "MyString",
      :title => "MyString",
      :permalink => "MyString",
      :accepted => false,
      :category_id => 1
    ).as_new_record)
  end

  it "renders new feed form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => feeds_path, :method => "post" do
      assert_select "input#feed_url", :name => "feed[url]"
      assert_select "input#feed_title", :name => "feed[title]"
      assert_select "input#feed_permalink", :name => "feed[permalink]"
      assert_select "input#feed_accepted", :name => "feed[accepted]"
      assert_select "input#feed_category_id", :name => "feed[category_id]"
    end
  end
end
