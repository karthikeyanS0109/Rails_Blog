class Topic < ApplicationRecord
  validates :title,presence: true
  validates :genre,presence: true
  has_many :posts,dependent: :destroy
end
