class FilesController < ApplicationController
  
  def ivr_menu
    send_file("#{Rails.root}/public/audios/ivr_menu.mp3",
      :filename => "ivr_menu.mp3",
      :type => "audio/mpeg")
  end
  
end
