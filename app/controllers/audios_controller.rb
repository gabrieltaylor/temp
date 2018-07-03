class AudiosController < ApplicationController
  
  def ivr
    send_file("#{Rails.root}/public/audios/ivr.mp3",
      :filename => "ivr.mp3",
      :type => "audio/mpeg")
  end
  
end
