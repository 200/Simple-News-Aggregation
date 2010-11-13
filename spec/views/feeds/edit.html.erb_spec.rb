require 'spec_helper'

describe "feeds/edit.html.erb" do
  before(:each) do
    @feed = assign(:feed, stub_model(Feed,
      :new_record? => false,
      :url => "MyString",
      :title => "MyString",
      :permalink => "MyString",
      :accepted => false,
      :category_id => 1
    ))
  end

  it "renders the edit feed form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => feed_path(@feed), :method => "post" do
      assert_select "input#feed_url", :name => "feed[url]"
      assert_select "input#feed_title", :name => "feed[title]"
      assert_select "input#feed_permalink", :name => "feed[permalink]"
      assert_select "input#feed_accepted", :name => "feed[accepted]"
      assert_select "input#feed_category_id", :name => "feed[category_id]"
    end
  end
end
