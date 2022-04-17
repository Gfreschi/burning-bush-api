# frozen_string_literal: true

module Api
  module V1
    class ComplaintsController < ApiController
      before_action :set_complaint, only: %i[show edit update destroy]

      def index
        @complaints = Complaint.where(user_id: current_user).all.order('created_at DESC')
        render json: @complaints
      end

      def show
        render json: @complaint
      end

      def new
        @complaint = Complaint.new
      end

      def edit; end

      def create
        @complaint = current_user.complaints.new(complaint_params)

        respond_to do |format|
          if @complaint.save
            IncidentGenerator.call(complaint: @complaint)
            format.json { render json: @complaint, status: :created }
          else
            format.json { render json: @complaint.errors, status: :unprocessable_entity }
          end
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
        @complaint.destroy

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_complaint
        @complaint = Complaint.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def complaint_params
        params.require(:complaint).permit(:user_id, :severity, :details, :latitude, :longitude)
      end
    end
  end
end
