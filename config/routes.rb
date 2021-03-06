Rails.application.routes.draw do
  resources :remarks, only: [:index, :create]
  resources :bills, only: [:show]

  resources :sessions, only: [:create, :index]
  get "/session/:code", to: "sessions#claim"

  root to: "pages#index"
end
