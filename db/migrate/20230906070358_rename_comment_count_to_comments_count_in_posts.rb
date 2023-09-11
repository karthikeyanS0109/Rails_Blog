class RenameCommentCountToCommentsCountInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :comment_count, :comments_count
  end
end
