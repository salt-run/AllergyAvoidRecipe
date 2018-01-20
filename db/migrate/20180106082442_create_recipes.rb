class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :menu
      t.string :image
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :recipes, :users
  end
end
