Rails.application.routes.draw do
  root 'home#index'
  resources :courses do 
    resources :lessons, only: [:create, :new] #,shallow: true
  end
  resources :instructors 
end
