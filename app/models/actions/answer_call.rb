class Actions::AnswerCall < Actions::Call
  def execute event, call
    call = create_call(event) if call.nil?
    telnyx_client.answer_call(call.call_control_id)
  end

  def load_call event
    super
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def valid? event, call
    call.nil? || call.initiated?
  end
  
  private
    def create_call event
      call = Call.build(event)
      call.save!
      call
    end
end
