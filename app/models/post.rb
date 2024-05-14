class Post < ApplicationRecord
  belongs_to :user 
  validates  :user_id, presence: true 
  validates  :content, presence: true, length: { maximum: 140 } 
  
  has_one :active_reply_relationship, class_name: "ReplyRelationShip", foreign_key: "reply_post_id", dependent: :destroy
  has_one :main_post, through: :active_reply_relationship, source: :main_post
  has_many :passive_reply_relationships, class_name: "ReplyRelationShip", foreign_key: "main_post_id", dependent: :destroy
  has_many :reply_posts, through: :passive_reply_relationships, source: :reply_post

  def reply?
    !self.active_reply_relationship.nil?
  end

end
