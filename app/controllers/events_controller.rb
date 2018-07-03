class EventsController < ApplicationController

  def handle_event
    case params[:event_type]
    when "call_initiated"
      telnyx_client.answer_call(call_control_id)
    when "call_answered"
      telnyx_client.play_audio(call_control_id, ENV['VOICE_TRACK_URL'])
    when "dtmf"
      handle_dtmf
    else
      head :ok
    end
  end

  private

    def handle_dtmf
      telnyx_client.hangup_call(call_control_id)
    end

    def call_control_id
      params[:payload][:call_control_id]
    end

    def telnyx_client
      @telnyx_client ||= TelnyxClient.new
    end
end
