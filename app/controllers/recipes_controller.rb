class RecipesController < ApplicationController

  def index
    #@recipes = Recipe.all
    if params[:search]

      #コードを簡略化できないか検討が必要 start ---
      #@user_allergies = current_user.user_allergies
      #allergy_food = []
      #i = 0
      #@user_allergies.each do |all|
      #  allergy_food[i] = all.allergy_food
      #  i += 1
      #end
      #コードを簡略化できないか検討が必要 end ---

      @recipes = Recipe.search(params[:search]).page(params[:page])
      #@recipes = Recipe.search(params[:search], allergy_food).page(params[:page])

    elsif params[:not_allergy_search]
      # リファリタリングする
      recipes = Recipe.where(id: params[:ids]).page(params[:page])

      user_allergies = current_user.user_allergies

      user_allergy_array = []
      user_allergies.each do |user_allergy|
        user_allergy_array << user_allergy.allergy_food
      end

     recipe_exclusion_id = []
     recipes.each do |recipe|
       recipe.recipe_foodstuffs.each do |recipe_foodstuff|
         user_allergy_array.each do |user_allergy|
           if user_allergy === recipe_foodstuff.foodstuff
             recipe_exclusion_id << recipe.id
           end
         end
       end
     end

     if recipe_exclusion_id.nil?
       @recipes = recipes.page(params[:page])
     else
       @recipes = recipes.where.not(id: recipe_exclusion_id).page(params[:page])
     end

    elsif params[:my_recipe]
      @recipes = Recipe.where(user_id: params[:id]).page(params[:page])
    elsif
      @recipes = Recipe.order("favorite_count DESC").limit(100).page(params[:page])
    else
      @recipes = Recipe.page(params[:page])

    end
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_foodstuffs.build
    @recipe.recipe_steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.favorite_count = 0
    if @recipe.save
      redirect_to recipes_path, notice: "#{@recipe.menu}＿レシピを登録しました"
    else
      render 'new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipes_path, notice: "#{@recipe.menu}＿レシピを編集しました"
    else
      render 'edit'
    end
  end


  def show
    @recipe = Recipe.find(params[:id])
    @favorite = current_user.favorites.find_by(recipe_id: @recipe.id)

  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'レシピを削除しました'
  end

  private
  def recipe_params
    params.require(:recipe).permit(
      :menu, :image, :user_id, :favorite_count,
      recipe_foodstuffs_attributes: [:id, :foodstuff, :quantity, :recipe_id, :_destroy],
      recipe_steps_attributes: [:id, :working_process, :image, :recipe_id, :_destroy],
    )
  end


end
