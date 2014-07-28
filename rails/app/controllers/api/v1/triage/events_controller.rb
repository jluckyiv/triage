class Api::V1::Triage::EventsController < ApplicationController

  def create
    render json: Event.create(event_params)
  end

  def event_params
    params.require(:event).permit(:matter_id, :category, :subject, :action)
  end
end
