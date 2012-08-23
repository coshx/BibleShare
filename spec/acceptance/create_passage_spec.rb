require 'acceptance/acceptance_helper'

feature "Create a passage", %q{
  As an user,
  I want to create a passage by simply typing the verse range (i.e. John 3:16-20),
  So that I do not have to copy/paste it from other sites and worry about formatting
} do

  background do

  end

  scenario "Create a passage" do
    visit '/passages/new'
    fill_in 'Title', :with => 'First passage'
    fill_in 'Bible', :with => 'John 3:16-20; Genesis 4:5-10'
    fill_in 'Content', :with => 'Please share your thoughts!'
    click_button 'Save'
    page.should have_content('John 3:16-20')
    page.should have_content('Genesis 4:5-10')
    page.should have_content('For God so loved the world')
    page.should have_content('But unto Cain')
  end
end
