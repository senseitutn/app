class VideosController < ApplicationController
	respond_to :html

	def index
		@user = User.find_by(:id => params[:user_id])
	end

	def show
		@video = Video.find(params[:id])
	end

	def new
		@video = Video.new
	end

	def edit
		@video = Video.find(params[:id])
	end

	def create
		@video = Video.create(video_params)

		# seteo otros parametros (es muy sucio setearlo aca!!)
    	@video.url = @video.video.url
    	@video.uploaded_at = DateTime.now

    	# TODO: crear un screenshot del video y asociarle la imagen
    	@video.save!

		if @video
			flash[:notice] = 'Se ha subido el video correctamente'
			redirect_to @video
		else
			flash[:notice] = 'No se ha podido subir el video'
			render "new"
		end		
	end

	def update
		@video = Video.update(params[:id], video_params)

		if @video.save
			redirect_to @video
		else
			render 'edit'
		end
	end

	def destroy
		@video = Video.find(params[:id])
		@video.destroy

		redirect_to videos_path
	end

	private
		def video_params
			params.require(:video).permit(:title,:url,:description,:duration,:uploaded_at,:video)
		end
end
