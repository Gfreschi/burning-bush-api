# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  # As we don’t need the app authorization, we can skip the authorizations and authorized_applications controller.
  # We can also skip the applications controller, as users won’t be able to create or delete OAuth application.
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
  #                                   registrations: 'users/registrations',
  #                                   sessions: 'users/sessions' }

  draw :api

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
