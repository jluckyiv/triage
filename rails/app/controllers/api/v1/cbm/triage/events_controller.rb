class Api::V1::Cbm::Triage::EventsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def show
    render json: Event.find(params[:id])
  end

  def create
    render json: Event.create(event_params)
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: {
      event: {
        id: 0,
        matter_id: 0,
        category: "",
        subject: "",
        action: "",
        unix_timestamp: 0
      }
    }
  end

  def event_params
    params.require(:event).permit(:matter_id, :category, :subject, :action, :unix_timestamp)
  end
end
