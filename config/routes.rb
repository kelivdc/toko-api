Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
                       sessions: "user/sessions",
                     }
  root to: "home#index"
  namespace :api do
    namespace :v1 do
      get "users", to: "user#index"
      post "users", to: "user#create"
      get "users/:id", to: "user#show"
      put "users/:id", to: "user#update"
      delete "users/:id", to: "user#destroy"

      get "categories", to: "category#index"
      post "categories", to: "category#create"
      get "categories/:id", to: "category#show"
      put "categories/:id", to: "category#update"
      delete "categories/:id", to: "category#destroy"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
