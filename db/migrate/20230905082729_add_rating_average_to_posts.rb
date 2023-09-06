class AddRatingAverageToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :rating_average, :decimal, default: 0.0
  end
end
