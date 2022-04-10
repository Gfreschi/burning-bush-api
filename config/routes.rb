Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  namespace :api do
    namespace :v1 do
      resources :users
      resources :complaints
    end
  end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
end
