class PagesController < ApplicationController
  def home
  end
  
  def public_share
    @passages = Passage.public_passages
  end
  
  def private_share
    @passages = []
    Passage.private_passages.each do |passage|
      if((passage.permission.users.include? current_user) || (passage.user.eql? current_user))
        @passages << passage
      end
    end
  end
end
