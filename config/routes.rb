Rails.application.routes.draw do

  post 'events', to: 'events#handle_event'
  get 'audios/ivr', to: 'audios#ivr'
  
end
