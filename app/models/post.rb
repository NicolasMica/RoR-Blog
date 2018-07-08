class Post < ApplicationRecord

  validates :name, :content, :image, :user_id, presence: true

  belongs_to :user

  has_many :comments, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :comments

  mount_uploader :image, PostUploader

end
