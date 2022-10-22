# frozen_string_literal: true

module Api
  module V1
    module Web
      class ComplaintsController < ApiController
        include ApplicationHelper

        before_action :set_complaint, only: %i[show update destroy]

        # skip_before_action :doorkeeper_authorize!

        def index
          @complaints = Complaint.where(user_id: current_user).all.order('created_at DESC')
          render json: @complaints
        end

        def show
          render json: @complaint
        end

        def create
          @complaint = current_user.complaints.new(complaint_params)

          if @complaint.save
            render json: @complaint, status: :created
          else
            render json: @complaint.errors, status: :unprocessable_entity
          end
        end

        def update
          respond_to do |format|
            if @complaint.update(user_params)
              format.json { render :show, status: :ok, location: @complaint }
            else
              format.json { render json: @complaint.errors, status: :unprocessable_entity }
            end
          end
        end

        def destroy
          if @complaint.destroy
            render json: { message: 'Complaint deleted' }, status: :ok
          else
            format.json { render json: @complaint.errors, status: :unprocessable_entity }
          end
        end

        def latest
          @last_complaint = Complaint.where(user: current_user).last
          render json: @last_complaint
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_complaint
          @complaint = Complaint.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def complaint_params
          params.require(:complaint).permit(:user_id, :kind, :severity, :details, :latitude, :longitude, :image)
        end
      end
    end
  end
end
