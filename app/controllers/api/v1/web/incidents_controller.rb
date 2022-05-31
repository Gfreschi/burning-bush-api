# frozen_string_literal: true

module Api
  module V1
    module Web
      class IncidentsController < ApiController
        include ApplicationHelper

        before_action :set_incident, only: %i[show]

        skip_before_action :doorkeeper_authorize!

        def index
          @incidents = Incident.all
          render json: @incidents
        end

        def show
          render json: @incident
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_incident
          @incident = Incident.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def incident_params
          params.require(:incident)
        end
      end
    end
  end
end
