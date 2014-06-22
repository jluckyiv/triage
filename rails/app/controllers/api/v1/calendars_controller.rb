module Api
  module V1
    class CalendarsController < ApplicationController

      def index
        render json: Calendar.all
      end

      def show
        render json: Calendar.friendly.find(params[:id])
      end

      rescue_from ActiveRecord::RecordNotFound do
        render json: {
          calendar: {
            id: 0,
            date: "None"
          }
        }
      end

    end
  end
end
