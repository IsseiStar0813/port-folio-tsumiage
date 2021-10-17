Rails.application.routes.draw do
  
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'calender/calender'
  root "landing_pages#home"
  get "/signup", to: "users#new"
  resources :users, :except => :index
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :posts, only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  get "/index", to: "posts#index"
  get "/search", to: "posts#search"
end
