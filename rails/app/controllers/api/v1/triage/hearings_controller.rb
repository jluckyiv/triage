class Api::V1::Triage::HearingsController < ApplicationController

  def show
    render json: Hearing.find(params[:id])
  end

  def update
    hearing = Hearing.find(params[:id])
    hearing.update_attribute(:interpreter, params[:interpreter])
    render json: hearing
  end

  def hearing_params
    params.require(:hearing).permit(:interpreter)
  end
end

