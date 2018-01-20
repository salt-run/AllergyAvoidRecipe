class RecipeFoodstuff < ApplicationRecord

  validates :foodstuff, presence: true
  validates :quantity, presence: true

  belongs_to :recipe


end
