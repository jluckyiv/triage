module Api
  module V1
    module Cbm
      module Triage
        class EventsController < ApplicationController

          skip_before_action :verify_authenticity_token

          def show
            render json: Event.find(params[:id])
          end

          def create
            binding.pry
            render json: Event.create(event_params)
          end

          rescue_from ActiveRecord::RecordNotFound do
            render json: {
              event: {
                id: 0,
                case_number_id: 0,
                category: "",
                subject: "",
                action: "",
                unix_timestamp: 0
              }
            }
          end

          def event_params
            params.require(:event).permit(:case_number_id, :category, :subject, :action, :unix_timestamp)
          end
        end
      end
    end
  end
end

