# frozen_string_literal: true

module Authentication
  class ExternalAuthGoogle
    def initialize(access_code)
      @access_code = access_code
      @user_data = user_data
    end

    def app_auth_data
      { client_id: Rails.application.credentials[:GOOGLE_OAUTH_CLIENT_ID],
        client_secret: Rails.application.credentials[:GOOGLE_OAUTH_CLIENT_SECRET] }
    end

    def user!
      return if user_data.blank? || uid.blank?

      User.find_by(uid:) || create_user!
    end

    def create_user!
      User.create!(user_params)
    end

    def fetch_access_token
      if @access_token.present?
        @access_token
      else
        uri = URI.parse('https://www.googleapis.com/oauth2/v3/token')
        params = {
          client_id: app_auth_data[:client_id],
          client_secret: app_auth_data[:client_secret],
          grant_type: 'authorization_code',
          code: @access_code
        }
        response = Net::HTTP.post_form(uri, params)
        data = JSON.parse(response.body)
        if data['access_token'].present?
          @access_token ||= data['access_token']
        else
          puts data
          nil
        end
      end
    end

    def user_data
      access_token = fetch_access_token
      if access_token.present?
        google = URI.parse('https://www.googleapis.com/plus/v1/people/me?access_token=' +
                               access_token)
        response = Net::HTTP.get_response(google)
        JSON.parse(response.body)
      end
    end

    def get_user!
      if @user_data.present?
        # below you should implement the logic to find/create a user in your app basing on @user_data
        # It should return a user object
        User.authorize_from_external(@user_data)
      end
    end
  end
end
