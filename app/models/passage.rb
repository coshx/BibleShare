class Passage < ActiveRecord::Base
  has_many :posts
  attr_accessible :bible, :content, :title, :scripture
end
