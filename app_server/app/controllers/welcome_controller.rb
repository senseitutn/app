class WelcomeController < ApplicationController
  def index
  	#@video = Video.last

  	@youtube_video = YoutubeVideo.new
  	@youtube_video.url = "https://www.youtube.com/watch?v=i2be-3LAyFk"
  	
  	VideoService.download_from_youtube(@youtube_video)
  	VideoService.split_into_frames(@youtube_video)
  end
end
