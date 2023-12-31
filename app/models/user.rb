class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,:trackable,:lockable

  has_many :comments
  has_many :posts

  has_and_belongs_to_many :posts, join_table: "posts_users_read_status", dependent: :destroy

  has_many :comment_ratings
  has_many :comments,through: :comment_ratings
end
