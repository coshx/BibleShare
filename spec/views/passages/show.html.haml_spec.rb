require 'spec_helper'

describe "passages/show.html.haml" do
  before(:each) do
    @passage = assign(:passage, stub_model(Passage,
      :title => "Title",
      :bible => "Bible",
      :content => "Content"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Bible/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Content/)
  end
end
