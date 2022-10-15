# frozen_string_literal: true

module Api
  module V1
    module Users
      class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        # You should configure your model like this:
        # devise :omniauthable, omniauth_providers: [:twitter]

        # You should also create an action method in this controller like this:
        # def twitter
        # end

        def google_oauth2
          user = User.from_omniauth(auth)

          if user.present?
            render json: { user: user }, status: :ok
            # flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Google')
          else
            render json: { error: I18n.t('devise.omniauth_callbacks.failure', kind: 'Google', reason: 'User not found') }
            # flash[:alert] = I18n.t('devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized.")
          end
        end

        # More info at:
        # https://github.com/heartcombo/devise#omniauth

        # GET|POST /resource/auth/twitter
        # def passthru
        #   super
        # end

        # GET|POST /users/auth/twitter/callback
        # def failure
        #   super
        # end

        # protected

        # The path used when OmniAuth fails
        # def after_omniauth_failure_path_for(scope)
        #   super(scope)
        # end

        private

        def auth
          @auth ||= request.env['omniauth.auth']
        end
      end
    end
  end
end
