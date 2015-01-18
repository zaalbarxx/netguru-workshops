Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :products do
      resources :reviews
    end
  end

  get '/user/:id/profile', to: 'users#profile', as: 'users_profile'
  get '/users', to: 'users#list', as: 'users_list'
  root 'categories#index'
end
