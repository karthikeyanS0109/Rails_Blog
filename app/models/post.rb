class Post < ApplicationRecord
  validates :description,presence: true
  belongs_to :topic
end
