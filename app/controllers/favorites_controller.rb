class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.create(recipe_id: params[:recipe_id])
    #redirect_to recipes_url, noteic: "#{favorite.recipe.user.name}さんのレシピをお気に入り登録しました"
    recipe = Recipe.find(params[:recipe_id])
    recipe.favorite_count =+1 
    recipe.update(:favorite_count => recipe.favorite_count)
    redirect_to recipe_path(params[:recipe_id]), noteic: "#{favorite.recipe.user.name}さんのレシピをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(recipe_id: params[:recipe_id]).destroy
    #redirect_to recipes_url, notice: "#{favorite.recipe.user.name}さんのブログをお気に入り解除しました"
    recipe = Recipe.find(params[:recipe_id])
    recipe.favorite_count =- 1
    recipe.update(:favorite_count => recipe.favorite_count)
    redirect_to recipe_path(params[:recipe_id]), notice: "#{favorite.recipe.user.name}さんのレシピをお気に入り解除しました"
  end

  def show
    @favorite_recipes = current_user.favorite_recipes

  end

end
