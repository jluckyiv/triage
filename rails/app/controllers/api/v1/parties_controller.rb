class Api::V1::PartiesController < ApplicationController

  def index
    cc = params[:cc].nil? ? "F" : URI.escape(params[:cc])
    ct = params[:ct].nil? ? "RID" : URI.escape(params[:ct])
    cn = URI.escape(params[:cn])
    uri = "http://riv-dev1/confidentialbenchmemo/api/v1/parties.aspx?cc=#{cc}&ct=#{ct}&cn=#{cn}"
    render json: json_from_cbm_uri(uri)
  end

end
