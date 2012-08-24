class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :passage
  belongs_to :user
  attr_accessible :content, :passage_id, :user_id
end
