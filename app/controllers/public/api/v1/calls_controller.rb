module Public
  module Api
    module V1
      class CallsController < ApplicationController
        protect_from_forgery except: :create

        def create
          @resource = CallForm.new(call_params)
          if @resource.save
            render :show, status: :created
          else
            render json: @resource.errors, status: :unprocessable_entity
          end
        end

        private

        def call_params
          params.permit(:from, :to)
        end
      end
    end
  end
end
