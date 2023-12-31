class Tag < ApplicationRecord
  has_many :taggables,dependent: :destroy
  has_many :posts,through: :taggables
  validates :name,presence: true
end
