class Post < ApplicationRecord
  validates :description,presence: true
  has_one_attached :image
  belongs_to :topic
  has_many :comments
  has_many :ratings
  has_many :taggables,dependent: :destroy
  has_many :tags,through: :taggables
end
