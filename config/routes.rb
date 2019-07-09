Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :create, :update]
  resources :weights, only: [ :show, :create, :destroy, :update]
  get "/weights/user/:id", to: "weights#index", as: "index"

  post "/auth/create", to: "auth#create"
  get "/auth/show", to: "auth#show"


end
