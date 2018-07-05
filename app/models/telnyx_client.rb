class TelnyxClient
  include HTTParty
  base_uri "https://api.telnyx.com"
  headers "Accept" => "application/json"

  def initialize
    @auth = {username: ENV["TELNYX_API_KEY"], password: ENV["TELNYX_API_SECRET"]}
  end

  def answer_call(call_control_id)
    call_action("answer", call_control_id)
  end

  def hangup_call(call_control_id)
    call_action("hangup", call_control_id)
  end

  def transfer_call(call_control_id, from, to)
    body = {from: from, to: to}
    call_action("transfer", call_control_id, body)
  end

  def play_audio(call_control_id, audio_url)
    body = {audio_url: audio_url}
    call_action("playback_start", call_control_id, body)
  end

  private

    def call_action(action, call_control_id, body = nil)
      options = {body: body.to_json, basic_auth: @auth}
      self.class.post("/calls/#{call_control_id}/actions/#{action}", options)
    end
end
