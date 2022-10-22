# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  # As we don’t need the app authorization, we can skip the authorizations and authorized_applications controller.
  # We can also skip the applications controller, as users won’t be able to create or delete OAuth application.
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  # https://github.com/heartcombo/devise/issues/3663
  devise_for :users, controllers: {
    confirmations: 'api/v1/users/confirmations',
    passwords: 'api/v1/users/passwords'
    # omniauth_callbacks: 'api/v1/users/omniauth_callbacks'
  }, skip: %i[registrations sessions omniauth_callbacks]

  draw :api
end
