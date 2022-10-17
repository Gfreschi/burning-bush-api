# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < Devise::ConfirmationsController
        skip_before_action :doorkeeper_authorize!, only: %i[create show]
        # GET /resource/confirmation/new
        def new
          super
        end

        # POST /resource/confirmation
        def create
          self.resource = resource_class.send_confirmation_instructions(resource_params)
          yield resource if block_given?
      
          if successfully_sent?(resource)
            render json: { message: "Confirmation email sent" }, status: :ok
          else
            render json: { errors: resource.errors }, status: :unprocessable_entity
          end
        end

        # GET /resource/confirmation?confirmation_token=abcdef
        def show
          self.resource = resource_class.confirm_by_token(params[:confirmation_token])
          yield resource if block_given?
      
          if resource.errors.empty?
            render json: { message: "Email Confirmado", redirect_uri: "localhost:3001" }, status: :ok
          else
            render json: { errors: resource.errors }, status: :unprocessable_entity
          end
        end

        protected

        # The path used after resending confirmation instructions.
        def after_resending_confirmation_instructions_path_for(resource_name)
          is_navigational_format? ? new_session_path(resource_name) : '/'
        end

        # The path used after confirmation.
        def after_confirmation_path_for(resource_name, resource)
          if current_user
            redirect_to "localhost:3001"
          else
            redirect_to "localhost:3001"
          end
        end
      end
    end
  end
end
