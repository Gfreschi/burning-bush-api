# frozen_string_literal: true

class ApiController < ApplicationController
  # equivalent of authenticate_user! on devise, but this one will check the oauth token
  # before_action :authenticate_user!
  before_action :doorkeeper_authorize!
  before_action :current_user

  # Skip checking CSRF token authenticity for API requests.
  # protect_from_forgery with: CustomStrategy -> issue
  skip_before_action :verify_authenticity_token, raise: false

  # Set response type
  respond_to :json

  # helper method to access the current user from the token
  def current_user
    return unless doorkeeper_token

    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end
end
