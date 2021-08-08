Rails.application.routes.draw do
  
  root "static_pages#home"
  get "/signup", to: "users#new"
  resources :user, :except => :index
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
