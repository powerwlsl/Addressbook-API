Rails.application.routes.draw do
  resources :users do
    resources :organizationsusers
  end

  resources :organizations do
    resources :organizationsusers, only: [:index,:create]
  end

  namespace :admin do 
    resources :organizations
  end

  post '/auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'
end
