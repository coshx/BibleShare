require 'acceptance/acceptance_helper'

feature "Comment on a post", %q{
  As an user,
  I want to comment what other people shared
  So that I can express my opinion about their thoughts
} do

  background do
    passage = FactoryGirl.create(:passage)
    post = FactoryGirl.create(:post, :passage_id => passage.id)
    comment = FactoryGirl.create(:comment, :post_id => post.id)
  end

  scenario "Create a post" do
    visit '/passages'
    click_link 'Show'
    click_link 'Comment on this post'
    fill_in 'Content', :with => 'Thanks for sharing!'
    click_button 'Save'
    page.should have_content('John 3:16-20')
    page.should have_content('Good passage!')
    page.should have_content('Thanks for sharing!')
  end
  
  scenario "Able to see all contents while commenting", :js => true do
    visit '/passages'
    click_link 'Show'
    click_link 'Comment on this post'
    page.should have_content('Content')
    page.should have_content('John 3:16-20')
    page.should have_content('Good passage!')
    page.should have_content('Good sharing!')
  end
end
