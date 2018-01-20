class CreateRecipeSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_steps do |t|
      t.string :working_process
      t.string :image
      t.integer :recipe_id
      t.timestamps
    end
    add_foreign_key :recipe_steps, :recipes
  end
end
