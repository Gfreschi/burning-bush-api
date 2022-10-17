# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    scope :users, module: :users do
      post '/', to: 'registrations#create', as: :user_registration
    end

    devise_for :users, controllers: {
      confirmations: 'api/v1/users/confirmations',
      passwords: 'api/v1/users/passwords'
      #omniauth_callbacks: 'api/v1/users/omniauth_callbacks'
    }, skip: %i[registrations sessions omniauth_callbacks]

    resources :complaints

    namespace :mobile do
      resources :complaints
    end

    namespace :web do
      resources :complaints
      get 'latest', to: 'complaints#latest'
      resources :incidents
    end

    get '/users/me', to: 'users#me'
  end
end

scope :api do
  scope :v1 do
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications
    end
  end
end
