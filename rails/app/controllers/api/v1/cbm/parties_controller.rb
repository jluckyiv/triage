class Api::V1::Cbm::PartiesController < ApplicationController

  def index
    case_numbers = params[:case_number]
    render json: CbmPartiesQuery.where(case_numbers: case_numbers)
  end

  def show
    case_number = params[:id]
    render json: CbmPartiesQuery.find(case_number)
  end

end
