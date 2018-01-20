class CreateRecipeFoodstuffs < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_foodstuffs do |t|
      t.string :foodstuff
      t.string :quantity
      t.integer :recipe_id
      t.timestamps
    end
    add_foreign_key :recipe_foodstuffs, :recipes
  end
end
