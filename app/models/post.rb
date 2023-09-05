class Post < ApplicationRecord
  validates :description,presence: true
  belongs_to :topic
  has_one_attached :image
  has_many :comments
  has_many :ratings
  has_many :taggables,dependent: :destroy
  has_many :tags,through: :taggables
  belongs_to :user
  has_and_belongs_to_many :users, join_table: "posts_users_read_status", dependent: :destroy

  scope :filtered_by_date_range, ->(from_date, to_date) {
    @from_date = from_date
    @to_date = to_date
    where(created_at: from_date.beginning_of_day..to_date.end_of_day)
  }

end
