# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :orders do
    member do
      get "checkout"
      get "payment_success"
      get "payment_failed"
    end
  end
end
