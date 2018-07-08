class Comment < ApplicationRecord

  validates :content, :post_id, :user_id, presence: true

  belongs_to :user
  belongs_to :post

end
