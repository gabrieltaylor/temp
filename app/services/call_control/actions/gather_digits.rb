module CallControl::Actions
  class GatherDigits < Call
    def execute event, call
      telnyx_client.gather(call.call_control_id, audio_url, max: 1, timeout: 10_000, valid_digits: "12")
    end

    def call_status_after_execution
      "awaiting_gather_end"
    end

    private
      def audio_url
        ENV['IVR_MENU_URL']
      end
  end
end
