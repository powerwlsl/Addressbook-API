Rails.application.routes.draw do
  resources :users do
    resources :organizations_users
  end

  resources :organizations do
    resources :organizations_users, only: [:index,:create]
  end

  namespace :admin do 
    resources :organizations
  end

  post '/auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'
end
