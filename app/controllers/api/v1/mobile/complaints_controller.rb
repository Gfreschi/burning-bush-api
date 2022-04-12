# frozen_string_literal: true

module Api
  module V1
    module Mobile
      class ComplaintsController < ApiController
        include ApplicationHelper

        before_action :set_complaint, only: %i[show]
        before_action :is_admin?

        skip_before_action :doorkeeper_authorize!

        def index
          @complaints = Complaint.all
          render json: @complaints
        end

        def show
          render json: @complaint
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_complaint
          @complaint = Complaint.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def complaint_params
          params.require(:complaint)
        end
      end
    end
  end
end
