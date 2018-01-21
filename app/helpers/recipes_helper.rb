module RecipesHelper


  def get_index_recipe_id
    #unless @recipes_id.nil?
      @recipes_id = []
      @recipes_all.each do |recipe|
        @recipes_id << recipe.id
      end
    #end
    #puts @recipes_id
  end

end
