require 'acceptance/acceptance_helper'

feature "Private share", %q{
  As a creator of a passage
  I want to limit who can view and post on the passage
  So that I can encourage intimate sharing
} do

  background do
    passage_owner = FactoryGirl.create(:user, :email => 'passage_owner@email.com', :name => 'Passage Owner', :username => 'passage1234')
    private_share_member = FactoryGirl.create(:user, :email => 'private_share_member@email.com', :name => 'Private Mameber', :username => 'private1234')                               
    normal_user = FactoryGirl.create(:user, :email => 'normal_user@email.com', :name => 'Normal User', :username => 'user1234')
    
    passage = FactoryGirl.create(:passage, :user_id => passage_owner.id, :is_private => true)
    permission = Permission.create()
    permission.users << private_share_member
    permission.save
    passage.permission = permission
    passage.save
  end
  
  scenario "Logged in as the passage owner" do
    ##Postponed writing test for creating a private passage due to the complexity of the user action performed while creating it## 
    visit '/users/sign_in'
    fill_in 'Email', :with => 'passage_owner@email.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit '/privateShare'
    
    page.should have_content('Test title')
  end

  scenario "Logged in as normal user" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'normal_user@email.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit '/privateShare'
    
    page.should have_content("You're not involved in any private sharing.")
  end
  
  scenario "Logged in as private group member" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'private_share_member@email.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit '/privateShare'
    
    page.should have_content('Test title')
  end
end
