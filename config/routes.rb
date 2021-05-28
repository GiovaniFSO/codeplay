Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :courses do 
    resources :lessons, only: [:create, :new] #,shallow: true
    post 'enroll', on: :member
    get 'my_courses', on: :collection
  end
  resources :lessons, only: [:show]
  resources :instructors 
end
