class Api::V1::Cbm::TriageHearingsController < ApplicationController
  def index
    date = params[:date]
    render json: CbmHearingsTriageQuery.where(date: date)
  end

  def show
    render json: CbmHearingsTriageQuery.find(params[:id])
  end
end
