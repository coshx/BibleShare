require 'acceptance/acceptance_helper'

feature "Updating/deleting contents", %q{
  As an user,
  I want to update/delete contents that I wrote
  So that I can fix my mistakes
} do

  background do
    owner = FactoryGirl.create(:user, :email => 'contents_owner@email.com', :name => 'Content Owner', :username => 'owner1234')
    poor_user = FactoryGirl.create(:user, :email => 'poor_user@email.com', :name => 'Poor User', :username => 'pooruser1234')
    
    passage = FactoryGirl.create(:passage, :user_id => owner.id)
    post = FactoryGirl.create(:post, :passage_id => passage.id, :user_id => owner.id)
    comment = FactoryGirl.create(:comment, :post_id => post.id, :user_id => owner.id)
    
    visit '/users/sign_in'
    fill_in 'Email', :with => 'contents_owner@email.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit '/passages'
    click_link 'Show'
  end

  scenario "Logged in as the contents owner - Updating", :js => true do
    page.should have_content('John 3:16-20')
    find('#edit_delete_passage').should have_content('Edit')
    find('#edit_delete_passage').should have_content('Delete')
    page.should have_content('Good passage!')
    find('#edit_delete_post').should have_content('Edit')
    find('#edit_delete_post').should have_content('Delete')
    page.should have_content('Good sharing!')
    find('#edit_delete_comment').should have_content('Edit')
    find('#edit_delete_comment').should have_content('Delete')
    
    #edit passage
    find('#edit_delete_passage').click_link 'Edit'
      #test if other contents are visible
      page.should have_content('Content')
      page.should have_content('Good passage!')
      page.should have_content('Good sharing!')
    fill_in 'Title', :with => 'New title'
    fill_in 'Bible', :with => 'Rev 3:1-5'
    fill_in 'Content', :with => 'new content!!'
    click_button 'Save'
    page.should_not have_content('Test title')
    page.should have_content('New title')
    page.should_not have_content('John 3:16-20')
    page.should_not have_content('For God so loved the world')
    page.should have_content('Revelation 3:1-5')
    page.should have_content('And unto the angel of the church in Sardis write')
    page.should_not have_content('Please share')
    page.should have_content('Content: new content!!')
    
    #edit post
    find('#edit_delete_post').click_link 'Edit'
      #test if other contents are visible
      page.should have_content('Content')
      page.should have_content('Revelation 3:1-5')
      page.should have_content('Good sharing!')
    fill_in 'Content', :with => 'I am changing the post content. @Romans 5:3-5@ Please meditate on this passage too!'
    click_button 'Save'
    page.should_not have_content('Good passage!')
    page.should have_content('Romans 5:3-5')
    page.should have_content('And hope maketh not ashamed')

    #edit comment
    page.should have_content('Good sharing!')
    find('#edit_delete_comment').click_link 'Edit'
      #test if other contents are visible
      page.should have_content('Content')
      page.should have_content('Revelation 3:1-5')
      page.should have_content('Romans 5:3-5')
    fill_in 'Content', :with => 'I am changing the comment. @Genesis 1:1-2@ God is good!'
    click_button 'Save'
    page.should_not have_content('Good sharing!')
    page.should have_content('Genesis 1:1-2')
    page.should have_content('In the beginning God created the heaven and the earth')
  end
  
  scenario "Logged in as the contents owner - Deleting", :js => true do
    #delete comment
    page.should have_content('Good sharing!')
    find('#edit_delete_comment').click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should_not have_content('Good sharing!')
    #delete post
    page.should have_content('Good passage!')
    find('#edit_delete_post').click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should_not have_content('Good passage!')
    #delete passage
    page.should have_content('Test title')
    find('#edit_delete_passage').click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should_not have_content('Test title')
  end
  
  scenario "Not logged in as the contents owner" do
    #Not logged in
    click_link 'Sign out'
    visit '/passages'
    click_link 'Show'
    
    page.should have_content('John 3:16-20')
    find('#edit_delete_passage').should_not have_content('Edit')
    find('#edit_delete_passage').should_not have_content('Delete')
    page.should have_content('Good passage!')
    find('#edit_delete_post').should_not have_content('Edit')
    find('#edit_delete_post').should_not have_content('Delete')
    page.should have_content('Good sharing!')
    find('#edit_delete_comment').should_not have_content('Edit')
    find('#edit_delete_comment').should_not have_content('Delete')
    
    #Logged in, but not as the contents owner
    visit '/users/sign_in'
    fill_in 'Email', :with => 'pooser_user@email.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit '/passages'
    click_link 'Show'
    
    page.should have_content('John 3:16-20')
    find('#edit_delete_passage').should_not have_content('Edit')
    find('#edit_delete_passage').should_not have_content('Delete')
    page.should have_content('Good passage!')
    find('#edit_delete_post').should_not have_content('Edit')
    find('#edit_delete_post').should_not have_content('Delete')
    page.should have_content('Good sharing!')
    find('#edit_delete_comment').should_not have_content('Edit')
    find('#edit_delete_comment').should_not have_content('Delete')
  end
end
