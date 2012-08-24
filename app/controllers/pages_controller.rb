class PagesController < ApplicationController
  def home
  end
  
  def public_share
    @passages = Passage.public_passages
  end
  
  def private_share
    @passages = Passage.private_passages
  end
end
