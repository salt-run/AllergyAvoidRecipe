Rails.application.routes.draw do

  root 'tops#index'

  #resources :tops, only: [:index]
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :recipes
  resources :favorites, only: [:show, :create, :destroy]

end
