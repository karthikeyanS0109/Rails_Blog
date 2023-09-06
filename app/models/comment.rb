class Comment < ApplicationRecord
  validates :content,presence: true

  belongs_to :post
  belongs_to :user

  has_many :comment_ratings,dependent: :destroy
  has_many :users,through: :comment_ratings

  after_create :count_comments
  after_destroy :count_deleted_comment

  private
  def count_comments
    post.counting_of_created_comments
  end

  def count_deleted_comment
    post.counting_of_deleted_comments
  end
end
