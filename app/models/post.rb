class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :passage
  attr_accessible :content, :passage_id
end
