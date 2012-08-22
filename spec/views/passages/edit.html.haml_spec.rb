require 'spec_helper'

describe "passages/edit.html.haml" do
  before(:each) do
    @passage = assign(:passage, stub_model(Passage,
      :new_record? => false,
      :title => "MyString",
      :bible => "MyString",
      :content => "MyString"
    ))
  end

  it "renders the edit passage form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => passage_path(@passage), :method => "post" do
      assert_select "input#passage_title", :name => "passage[title]"
      assert_select "input#passage_bible", :name => "passage[bible]"
      assert_select "input#passage_content", :name => "passage[content]"
    end
  end
end
