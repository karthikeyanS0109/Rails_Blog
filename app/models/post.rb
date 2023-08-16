class Post < ApplicationRecord
  validates :description,presence: true
  belongs_to :topic
  has_one_attached :image
  has_many :comments
  has_many :ratings
  has_many :taggables,dependent: :destroy
  has_many :tags,through: :taggables
  belongs_to :user

end
