class CommentRating < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  #=============== Validations ================
  validates :user_id,uniqueness: { scope: :comment_id }
end
