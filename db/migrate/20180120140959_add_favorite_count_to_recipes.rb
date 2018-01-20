class AddFavoriteCountToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :favorite_count, :integer
  end
end
