Rails.application.routes.draw do
  resources :remarks, only: [:index]
  resources :bills, only: [:show]
  root to: "pages#index"
end
