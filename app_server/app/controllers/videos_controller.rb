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

		# seteo parametros del video
    	@video.url = @video.video.url
    	@video.uploaded_at = DateTime.now

    	# TODO: este guardado es provisorio, hay que almacenarlo en un web service

    	#guardo el video 
    	if @video.save
    		# creo el screenshot (preview, en nuestro caso) del video
    		@movie = FFMPEG::Movie.new(@video.video.path)

    		#en el nombre mismo de screenshot le pongo la ruta (asi me ahorro el paso de indicarsela explicitamente) 
    		#  ejemplo: "/home/wizarmon/Documentos/mi_screenshot.jpg" 
			@screenshot = @movie.screenshot("#{Rails.root}/screenshots/#{@video.title}_screenshot.jpg", 
				seek_time: @movie.duration/2, resolution: '320x240')
			# Asocio el screenshot al video
			@image = Image.create(:video_id => @video.id, 
				:image => File.new("#{Rails.root}/screenshots/#{@video.title}_screenshot.jpg","r"))
			@image.url = @image.image.url
			@image.save
    	end 

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
