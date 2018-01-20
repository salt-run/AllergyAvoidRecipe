class CreateUserAllergies < ActiveRecord::Migration[5.1]
  def change
    create_table :user_allergies do |t|

      t.string :allergy_genre
      t.string :allergy_food
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :user_allergies, :users
  end
end
