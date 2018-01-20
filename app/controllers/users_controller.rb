class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    #@user_allergies = UserAllergy.find_or_initialize_by(user_id: @user.id)
    #@user_allergies = UserAllergy.new
  end

  def edit
    @user = User.find(params[:id])
    @user.user_allergies.build

  end

  def update
    @user = User.find(params[:id])
    puts "user_params"
    puts user_params
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end


private
  #def user_params
  #  params.require(:user).permit(:name, :email, :password, :password_confirmation,:profile_image)
  #end

  def user_params
    params.require(:user).permit(
      #:name, :email, :password, :password_confirmation, :profile_image,
      :name, :email, :password, :password_confirmation, :profile_image,
      user_allergies_attributes: [:id, :allergy_genre, :allergy_food, :user_id, :_destroy]
    )
  end



end
