class PostsUsersReadStatus < ActiveRecord::Migration[6.1]
  def change
    create_join_table :posts, :users, table_name: :posts_users_read_status do |t|
      t.index [:post_id, :user_id]
    end
  end
end
