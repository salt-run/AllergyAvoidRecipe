class Recipe < ApplicationRecord

  validates :menu, presence: true

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :recipe_foodstuffs, dependent: :destroy
  has_many :recipe_steps, dependent: :destroy

  #accepts_nested_attributes_for :recipe_foodstuffs, allow_destroy: true
  accepts_nested_attributes_for :recipe_foodstuffs,
                                reject_if: :reject_recipe_foodstuffs,
                                allow_destroy: true

  def reject_recipe_foodstuffs(attributes)
    exists = attributes[:id].present?
    foodstuff_empty = attributes[:foodstuff].blank?
    quantity_empty = attributes[:quantity].blank?
    attributes.merge!(_destroy: 1) if exists && foodstuff_empty && quantity_empty
    !exists && foodstuff_empty && quantity_empty
  end

  accepts_nested_attributes_for :recipe_steps,
                                reject_if: :reject_recipe_steps,
                                allow_destroy: true

  def reject_recipe_steps(attributes)
    exists = attributes[:id].present?
    process_empty = attributes[:working_process].blank?
    attributes.merge!(_destroy: 1) if exists && process_empty
    !exists && process_empty
  end


  mount_uploader :image, RecipeImageUploader

  def self.search(search)
  #def self.search(search, allergy_food)
    if search
      Recipe.where(['menu LIKE ?', "%#{search}%"])
      #Recipe.where(['menu LIKE ?', "%#{allergy_food}%"])
    else
      Recipe.all
    end
  end

  def self.search2(search)
  #def self.search(search, allergy_food)
    if search
      Recipe.where(['menu LIKE ?', "%#{search}%"])
      #Recipe.where(['menu LIKE ?', "%#{allergy_food}%"])
    else
      Recipe.all

    end
  end


  paginates_per 10  # 1ページあたり10項目表示


end
