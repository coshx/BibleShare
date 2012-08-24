class Passage < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  belongs_to :user
  attr_accessible :bible, :content, :title, :scripture, :user_id
end
