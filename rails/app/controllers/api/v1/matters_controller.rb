module Api
  module V1
    class MattersController < ApplicationController

      def index
        render json: CbmMatterFactory.find_all(params[:case_number])
        # render json: Calendar.friendly.find(params[:date])
        # CbmCalendarFactory.new.delay.run(
        #   date: params[:date],
        #   time: "8.15",
        #   departments: %w[F201 F301 F401 F402]
        # )
        # render json: MattersFactory.new(
        #   date: params[:date],
        #   time: "8.15",
        #   departments: %w[F201 F301 F401 F402]
        # ).run
        # end

        # rescue_from ActiveRecord::RecordNotFound do
        # render json: MattersFactory.new(
        #   date: params[:date],
        #   time: "8.15",
        #   departments: %w[F201 F301 F401 F402]
        # ).run
        # end
      end

      def show
        render json: CbmMatterFactory.find(params[:id])
      end

    end
  end
end

