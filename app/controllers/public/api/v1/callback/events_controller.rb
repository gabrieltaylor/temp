module Public
  module Api
    module V1
      module Callback
        class EventsController < ApplicationController
          protect_from_forgery except: :create

          def create
            if event_form.valid?
              # process event
              # generate response

              head :no_content
            else
              logger.error(event_form.errors.full_messages)
              render json: event_form.errors, status: :unprocessable_entity
            end
          end

          private

          def event_params
            params.permit(:from, :to)
          end

          def event_form
            @event_form ||= EventForm.new(event_params)
          end
        end
      end
    end
  end
end
