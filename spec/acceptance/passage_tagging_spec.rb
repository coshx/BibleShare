require 'acceptance/acceptance_helper'

feature "Tagging bible verses in posts/comments", %q{
  As an user,
  I want to tag other bible verses by simply typing the verse range in my posts and comments
  So that I do not have to manually paste or type the verses
} do

  background do
    passage = FactoryGirl.create(:passage)
    post = FactoryGirl.create(:post, :passage_id => passage.id)
  end

  scenario "Tagging in a post" do
    visit '/passages'
    click_link 'Show'
    click_link 'Share your thoughts'
    fill_in 'Content', :with => 'Found a good verse. @Colossians 3:23@'
    click_button 'Save'
    page.should have_content('John 3:16-20')
    page.should have_content('Good passage!')
    page.should have_content('And whatsoever ye do, do it heartily, as to the Lord, and not unto men')
  end
  
  scenario "Tagging in a comment" do
    visit '/passages'
    click_link 'Show'
    click_link 'Comment on this post'
    fill_in 'Content', :with => 'Found a good verse. @Colossians 3:23@'
    click_button 'Save'
    page.should have_content('John 3:16-20')
    page.should have_content('Good passage!')
    page.should have_content('And whatsoever ye do, do it heartily, as to the Lord, and not unto men')
  end
end
