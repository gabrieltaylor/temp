class EventsController < ApplicationController
  before_action :load_call, :update_call_status

  def handle_event
    case params[:event_type]
    when "call_initiated"
      answer_call
    when "call_answered"
      gather_digits
    when "gather_ended"
      handle_gather
    else
      head :ok
    end
  end

  private

    def answer_call
      @call = Call.build(params)
      if @call.save
        telnyx_client.answer_call(@call.call_control_id)
        head :ok
      else
        render json: @call.errors, status: :unprocessable_entity
      end
    end

    def handle_gather
      return unless @call.gather_ended?
      case params[:payload][:digits]
      when "1"
        telnyx_client.transfer_call(@call.call_control_id, @call.to, ENV['SUPPORT_PHONE_NUMBER'])
      when "2"
        telnyx_client.hangup_call(@call.call_control_id)
      else
        gather_digits
      end
    end

    def gather_digits
      telnyx_client.gather(@call.call_control_id, ENV['IVR_MENU_URL'], max: 1, timeout: 10_000)
    end

    def telnyx_client
      @telnyx_client ||= TelnyxClient.new
    end

    def load_call
      if params[:event_type] != "call_initiated" && params[:payload][:call_control_id]
        @call = Call.find_by(call_control_id: params[:payload][:call_control_id])
        raise ActiveRecord::RecordNotFound if @call.nil?
      end
    end

    def update_call_status
      @call.update_status(params[:event_type]) unless @call.nil?
    end
end
