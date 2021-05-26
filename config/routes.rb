Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :courses do 
    resources :lessons, only: [:create, :new] #,shallow: true
  end
  resources :lessons, only: [:show]
  resources :instructors 
end
