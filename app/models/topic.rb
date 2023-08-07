class Topic < ApplicationRecord
  validates :title,presence: true ,uniqueness: true
  validates :genre,presence: true
  has_many :posts,dependent: :destroy
end
