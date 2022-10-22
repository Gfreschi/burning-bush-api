# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    scope :users, module: :users do
      post '/', to: 'registrations#create', as: :user_registration
    end

    resources :complaints

    namespace :web do
      resources :complaints
      get 'latest', to: 'complaints#latest'
      resources :incidents
      post 'near_by', to: 'incidents#near_by'
    end

    get '/users/me', to: 'users#me'
  end
end

scope :api do
  scope :v1 do
    # TODO: verify if this is the best way to do this
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications
    end
  end
end
