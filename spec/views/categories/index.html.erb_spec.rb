require 'spec_helper'

describe "categories/index.html.erb" do
  before(:each) do
    assign(:categories, [
      stub_model(Category,
        :name => "Name",
        :permalink => "Permalink"
      ),
      stub_model(Category,
        :name => "Name",
        :permalink => "Permalink"
      )
    ])
  end

  it "renders a list of categories" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Permalink".to_s, :count => 2
  end
end
