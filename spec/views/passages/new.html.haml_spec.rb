require 'spec_helper'

describe "passages/new.html.haml" do
  before(:each) do
    assign(:passage, stub_model(Passage,
      :title => "MyString",
      :bible => "MyString",
      :content => "MyString"
    ).as_new_record)
  end

  it "renders new passage form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => passages_path, :method => "post" do
      assert_select "input#passage_title", :name => "passage[title]"
      assert_select "input#passage_bible", :name => "passage[bible]"
      assert_select "input#passage_content", :name => "passage[content]"
    end
  end
end
