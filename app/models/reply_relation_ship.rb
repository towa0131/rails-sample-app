class ReplyRelationShip < ApplicationRecord
  belongs_to :main_post, class_name: "Post"
  belongs_to :reply_post, class_name: "Post"
end
