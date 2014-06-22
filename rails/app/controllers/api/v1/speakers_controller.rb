module Api
  module V1
    class SpeakersController < ApplicationController

      def index
        render json: Speaker.all
      end

      def show
        render json: Speaker.find(params[:id])
      end

    end
  end
end
