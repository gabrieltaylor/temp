module CallControl::Actions
  class FinishCall < Call
    def valid? event, call
      not call.finished?
    end
  end
end
