# frozen_string_literal: true

module Api
  module V1
    module Web
      class IncidentsController < ApiController
        include ApplicationHelper

        before_action :set_incident, only: %i[show]

        skip_before_action :doorkeeper_authorize!

        def index
          @incidents = Incident.limit(100).order('created_at DESC')
          render json: @incidents
        end

        def show
          render json: @incident
        end

        def near_by
          @incidents_near_by = Incident.near_incidents(params[:latitude], params[:longitude])
          render json: @incidents_near_by
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

        def near_by_params
          params.permit(:latitude, :longitude)
        end
      end
    end
  end
end
