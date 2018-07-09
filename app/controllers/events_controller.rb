class EventsController < ApplicationController
  def handle_event
    EventHandler.handle(params)
    head :ok
  end
end
