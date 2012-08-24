class Passage < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  has_one :permission, :dependent => :destroy
  belongs_to :user
  attr_accessible :bible, :content, :title, :scripture, :user_id, :is_private
  
  scope :public_passages, where(:is_private => 'false')
  scope :private_passages, where(:is_private => 'true')
  
  validates :title, :presence => true
  validates :bible, :presence => true
  validates :scripture, :presence => true
end
