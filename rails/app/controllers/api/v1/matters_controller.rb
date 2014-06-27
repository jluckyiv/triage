module Api
  module V1
    class MattersController < ApplicationController

      skip_before_action :verify_authenticity_token

      def show
        render json: Event.find(params[:id])
      end

    end
  end
end

