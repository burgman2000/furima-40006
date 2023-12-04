Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :products do
    resources :buyers, only: [:index, :create]
  end
end 

