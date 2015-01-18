Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :products do
      resources :reviews
    end
  end

  get '/user/:id/profile', to: 'user#profile', as: 'user_profile'

  root 'categories#index'
end
