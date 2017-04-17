Rails.application.routes.draw do
  resources :organizations, only: [:index, :create, :destroy, :update] do
    resources :organizations_users, only: [:index,:create,:destroy]
  end
  
  
  post '/auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'
end
