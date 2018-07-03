require 'rails_helper'

describe EventsController do
  after do
    assert_response :success
  end

  context "call_initiated" do
    before do
      @params = JSON.parse(file_fixture("events/call_initiated.json").read)
      @call_control_id = @params["payload"]["call_control_id"]
    end

    it "should answer call" do  
      expect_any_instance_of(TelnyxClient).to receive(:answer_call).with(@call_control_id)
      post :handle_event, params: @params
    end
  end

  context "call_answered" do
    before do
      @params = JSON.parse(file_fixture("events/call_answered.json").read)
      @call_control_id = @params["payload"]["call_control_id"]
    end

    it "should playback audio" do
      expect_any_instance_of(TelnyxClient).to receive(:play_audio)
        .with(@call_control_id, ENV['VOICE_TRACK_URL'])
      post :handle_event, params: @params
    end
  end

  context "dtmf" do
    before do
      @params = JSON.parse(file_fixture("events/dtmf.json").read)
      @call_control_id = @params["payload"]["call_control_id"]
    end

    it "should transfer call to support when digit is 1" do
      @params["payload"]["digit"] = "1"
      expect_any_instance_of(TelnyxClient).to receive(:transfer_call)
        .with(@call_control_id, @params["payload"]["to"], ENV['SUPPORT_PHONE_NUMBER'])
      post :handle_event, params: @params
    end

    it "should hangup call when digit is 2" do
      @params["payload"]["digit"] = "2"
      expect_any_instance_of(TelnyxClient).to receive(:hangup_call).with(@call_control_id)
      post :handle_event, params: @params
    end

    it "should playback audio when digit is unknown" do
      @params["payload"]["digit"] = "9"
      expect_any_instance_of(TelnyxClient).to receive(:play_audio)
        .with(@call_control_id, ENV['VOICE_TRACK_URL'])
      post :handle_event, params: @params
    end
  end
end