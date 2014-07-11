module Api
  module V1
    class MattersController < ApplicationController

      def index
        # render json: Calendar.friendly.find(params[:date])
        # render json: CbmCalendarFactory.new(date: params[:date]).run
        render json: Matter.where(date: params[:date], time: '8.15')
      end

      rescue_from ActiveRecord::RecordNotFound do
        render json: CbmCalendarFactory.new(date: params[:date]).run
      end

    end
  end
end

