module Api
  module V1
    class CalendarsController < ApplicationController

      def show
        render json: Calendar.friendly.find(params[:id])
      end

      rescue_from ActiveRecord::RecordNotFound do
        render json: CbmCalendarFactory.new(date: params[:id]).run
        # render json: {
        #   calendar: {
        #     id: 0,
        #     date: params[:id]
        #   }
        # }
      end

    end
  end
end
