module Api
	module V1
		class VideosController < ApplicationController
			skip_before_filter  :verify_authenticity_token
			respond_to :json

			def index
				@videos = Video.all
			end
			
			def show
				respond_with Video.find(params[:id])
			end

			def create
				VideoService.create_video(params[:title], params[:description], params[:video])
			end

			def update
				respond_with Video.update(params[:id], params[:videos])
			end

			def destroy
				respond_with Video.destroy(params[:id])
			end

			###### Customs methods

			def create_from_link
				@youtube_video = YoutubeVideo.new
  				@youtube_video.url = params[:url]

  				VideoService.download_from_youtube(@youtube_video)
  				VideoService.process_video(@youtube_video)
			end

			def search_all
				@text = params[:text]
				@videos = Video.where("title LIKE ? OR description LIKE ?", "%#{@text}%","%#{@text}%")
			end

			#TODO: testear
			#trae los 5 mas populares
			def get_most_populars
				@videos = Video.order("reproduction_count desc").limit(5)
			end

			#TODO: testear
			def get_recents
					@videos = Video.order("created_at desc").limit(10)
			end

			private
			def video_params
				params.require(:video).permit(:title,:url,:description,:duration,:uploaded_at,:video)
			end
		end
	end
end