require 'acceptance/acceptance_helper'

feature "Deleting subcontents", %q{
  As an user,
  I want to delete the contents that belong to my content (i.e. comments on my post)
  So that I can be free from unwanted/offensive contents
} do

  background do
    passage_owner = FactoryGirl.create(:user, :email => 'passage_owner@email.com', :password => 'password', :password_confirmation => 'password', 
                                 :name => 'Sang Won Seo', :username => 'myaccnt')
    post_owner = FactoryGirl.create(:user, :email => 'post_owner@email.com', :password => 'password', :password_confirmation => 'password', 
                                      :name => 'Have Some Content', :username => 'post1234')                               
    comment_owner = FactoryGirl.create(:user, :email => 'comment_owner@email.com', :password => 'password', :password_confirmation => 'password', 
                                      :name => 'Have Some Content', :username => 'comment1234')
    
    passage = FactoryGirl.create(:passage, :user_id => passage_owner.id)
    post = FactoryGirl.create(:post, :passage_id => passage.id, :user_id => post_owner.id)
    comment = FactoryGirl.create(:comment, :post_id => post.id, :user_id => comment_owner.id)
  end

  scenario "Logged in as a passage owner", :js => true do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'passage_owner@email.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit '/passages'
    click_link 'Show'
    
    page.should have_content('John 3:16-20')
    page.should have_content('Good passage!')
    find('#edit_delete_post').should_not have_content('Edit')
    find('#edit_delete_post').should have_content('Delete')
    page.should have_content('Good sharing!')
    find('#edit_delete_comment').should_not have_content('Edit')
    find('#edit_delete_comment').should_not have_content('Delete')
    
    #delete post
    find('#edit_delete_post').click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should_not have_content('Good passage!')
  end
  
  scenario "Logged in as a post owner", :js => true do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'post_owner@email.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit '/passages'
    click_link 'Show'
    
    page.should have_content('John 3:16-20')
    page.should have_content('Good passage!')
    page.should have_content('Good sharing!')
    find('#edit_delete_comment').should_not have_content('Edit')
    find('#edit_delete_comment').should have_content('Delete')
    
    #delete comment
    page.should have_content('Good sharing!')
    find('#edit_delete_comment').click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should_not have_content('Good sharing!')
  end
end
