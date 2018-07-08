class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true

  has_many :posts, inverse_of: :user, dependent: :destroy
  has_many :comments, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :posts

  def fullname
    "#{firstname.titlecase} #{lastname.titlecase}"
  end
end
