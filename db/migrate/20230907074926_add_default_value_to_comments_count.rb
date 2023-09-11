class AddDefaultValueToCommentsCount < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :comments_count, :integer, default: 0
  end
end
