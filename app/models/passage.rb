class Passage < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  has_one :permission
  belongs_to :user
  attr_accessible :bible, :content, :title, :scripture, :user_id, :private
  
  scope :public_passages, where(:private => 'false')
  scope :private_passages, where(:private => 'true')
end
