class Actions::FinishCall < Actions::Call
  def valid? event, call
    not call.finished?
  end
end
