class VideosController < ApplicationController
	respond_to :html

	def index
		@videos = Video.all
		respond_with @videos
	end

	def show
		respond_with Video.find(params[:id])
	end

	def create
		respond_with Video.create(video_params)
	end

	def update
		respond_with Video.update(params[:id], video_params)
	end

	def destroy
		respond_with Video.destroy(params[:id])
	end


	private
		def video_params
			params.require(:video).permit(:name,:path,:description,:duration,:uploaded_at)
		end
end
