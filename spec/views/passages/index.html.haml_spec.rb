require 'spec_helper'

describe "passages/index.html.haml" do
  before(:each) do
    assign(:passages, [
      stub_model(Passage,
        :title => "Title",
        :bible => "Bible",
        :content => "Content"
      ),
      stub_model(Passage,
        :title => "Title",
        :bible => "Bible",
        :content => "Content"
      )
    ])
  end

  it "renders a list of passages" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Bible".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
