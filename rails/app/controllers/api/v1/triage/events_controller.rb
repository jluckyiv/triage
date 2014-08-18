class Api::V1::Triage::EventsController < ApplicationController

  def index
    render json: Event.where(matter_id: params[:matter_id])
  end

  def create
    render json: Event.create(event_params)
  end

  def destroy
    render json: Event.find(params[:id]).destroy
  end

  def event_params
    params.require(:event).permit(:matter_id, :category, :subject, :action)
  end
end
