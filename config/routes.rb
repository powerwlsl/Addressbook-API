Rails.application.routes.draw do
  resources :users do
    resources :organizationsusers
  end

  resources :organizations do
    resources :organizationsusers
  end
end
