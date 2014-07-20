class Api::V1::Cbm::MattersController < ApplicationController

  def index
    render json: CbmMatterQuery.find_all(params[:case_number])
  end

  def show
    render json: CbmMatterQuery.find(params[:id])
  end

end
