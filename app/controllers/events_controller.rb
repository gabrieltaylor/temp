class EventsController < ApplicationController

  def handle_event
    case params[:event_type]
    when "call_initiated"
      telnyx_client.answer_call(call_control_id)
    when "call_answered"
      play_ivr_audio
    when "dtmf"
      handle_dtmf
    else
      head :ok
    end
  end

  private

    def handle_dtmf
      payload = params[:payload]
      case payload[:digit]
      when "1"
        telnyx_client.transfer_call(call_control_id, payload[:to], ENV['SUPPORT_PHONE_NUMBER'])
      when "2"
        telnyx_client.hangup_call(call_control_id)
      else
        play_ivr_audio        
      end
    end

    def play_ivr_audio
      telnyx_client.play_audio(call_control_id, ENV['VOICE_TRACK_URL'])
    end

    def call_control_id
      params[:payload][:call_control_id]
    end

    def telnyx_client
      @telnyx_client ||= TelnyxClient.new
    end
end
