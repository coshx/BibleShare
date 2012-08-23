class Passage < ActiveRecord::Base
  has_many :posts
  belongs_to :user
  attr_accessible :bible, :content, :title, :scripture
end
