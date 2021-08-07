Rails.application.routes.draw do
  
  root "static_pages#home"
  get "/signup", to: "users#new"
  resources :users
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "logput", to: "sessions#destroy"
end
