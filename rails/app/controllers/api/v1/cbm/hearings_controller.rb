class Api::V1::Cbm::HearingsController < ApplicationController

  def index
    date = params[:date]
    dept = params[:dept]
    cc   = params[:cc]
    time = params[:time]
    render json: CbmHearingsQuery.where(date: date, dept: dept, cc: cc, time: time)
  end
end
