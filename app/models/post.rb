class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :passage
  belongs_to :user
  attr_accessible :content, :passage_id
end
