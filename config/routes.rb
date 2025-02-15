Rails.application.routes.draw do
 
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to:"home#top"
  get 'home/about', as:'about'

  resources :users, only: [:index, :show, :edit, :update, :create]
  resources :books, only: [:index, :new, :create, :show, :edit, :update, :destroy] 

end
