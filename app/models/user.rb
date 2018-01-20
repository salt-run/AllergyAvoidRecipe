class User < ApplicationRecord

  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255},
             format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: {minimum: 6}, on: :create

  before_save { email.downcase! }
  has_secure_password

  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe

  has_many :recipes, dependent: :destroy
  has_many :user_allergies, dependent: :destroy

  #accepts_nested_attributes_for :user_allergies, allow_destroy: true
  accepts_nested_attributes_for :user_allergies,
                                reject_if: :reject_user_allergies,
                                allow_destroy: true

  def reject_user_allergies(attributes)
    exists = attributes[:id].present?
    allergy_genre_empty = attributes[:allergy_genre].blank?
    allergy_food_empty = attributes[:allergy_food].blank?
    attributes.merge!(_destroy: 1) if exists && allergy_genre_empty && allergy_food_empty
    !exists && allergy_genre_empty && allergy_food_empty
  end

  mount_uploader :profile_image, UserImageUploader

end
