class RecipeStep < ApplicationRecord
  belongs_to :recipe

  mount_uploader :image, RecipeImageUploader

end
