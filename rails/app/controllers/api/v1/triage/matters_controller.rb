class Api::V1::Triage::MattersController < ApplicationController
  def index
    date = params[:date]
    render json: TriageMatter.where(date: date)
  end

  def show
    render json: TriageMatter.find(params[:id])
  end
end
