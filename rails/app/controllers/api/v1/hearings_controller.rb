class Api::V1::HearingsController < ApplicationController

  def index
    dept = URI.escape(params[:dept])
    date = params[:date].nil? ? Date.today.strftime("%Y%m%d") : URI.escape(params[:date])
    cc   = params[:cc].nil? ? "F" : URI.escape(params[:cc])
    uri = "http://riv-dev1/confidentialbenchmemo/api/v1/hearings.aspx?cc=#{cc}&dept=#{dept}&date=#{date}"
    render json: json_from_cbm_uri(uri)
  end

end
