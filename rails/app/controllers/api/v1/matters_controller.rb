class Api::V1::MattersController < ApplicationController
  def index
    cc = "F"
    dept = %w[F201 F301 F401 F402]
    date = params[:date]
    render json: CbmMattersQuery.where(cc: cc, dept: dept, date: date)
  end

  def show
    render json: CbmHearingsQuery.find(params[:id])
  end
end
