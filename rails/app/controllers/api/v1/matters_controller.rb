module Api
  module V1
    class MattersController < ApplicationController

      def index
        render json: Calendar.friendly.find(params[:calendar])
      end

      rescue_from ActiveRecord::RecordNotFound do
        render json: CbmCalendarFactory.new(date: params[:calendar]).run
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

