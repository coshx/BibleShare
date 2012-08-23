require 'acceptance/acceptance_helper'

feature "Create a post", %q{
  As an user,
  I want to share my thought about a passage
  So that others can benefit from it
} do

  background do
    passage = FactoryGirl.create(:passage)
  end

  scenario "Create a post" do
    visit '/passages'
    click_link 'Show'
    click_link 'Share your thoughts'
    fill_in 'Content', :with => 'I really like this passage. Thanks for uploading the passage.'
    click_button 'Save'
    page.should have_content('John 3:16-20')
    page.should have_content('I really like this passage')
  end
end
