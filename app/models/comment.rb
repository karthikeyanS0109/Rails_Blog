class Comment < ApplicationRecord
  validates :content,presence: true

  belongs_to :post
  belongs_to :user

  has_many :comment_ratings,dependent: :destroy
  has_many :users,through: :comment_ratings
end
