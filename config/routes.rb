Rails.application.routes.draw do
  resources :bills, only: [:show]
  root to: "pages#index"
end
