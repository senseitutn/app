class VideoService
	@@videos_base_directory = "#{Rails.root}/public/system/videos/youtube"

	def self.create_video(title, desc, video_file)
		@video = Video.create(:title => title, :description => desc, :video => video_file)

		# seteo parametros del video
    	@video.url = @video.video.url
    	@video.uploaded_at = DateTime.now

    	# TODO: este guardado es provisorio, hay que almacenarlo en un web service

    	if @video.save
    		create_screenshot(@video)
    	end
	end

	def self.download_from_youtube(youtube_video)
		#TODO: download_from youtube
		set_title(youtube_video)

		# elimino caracteres especiales para crear el directorio
		# donde se almacenará el archivo
		
		video_folder_name = youtube_video.title.gsub(/[^0-9A-Za-z]/, '')	 
		destiny_folder = "#{@@videos_base_directory}/#{video_folder_name}"
		system "mkdir #{destiny_folder}"
  		system "viddl-rb #{youtube_video.url} --save-dir #{destiny_folder}/"

  		#cambio el nombre del video, quitando caracteres especiales
  		file_name = Dir.new(destiny_folder).entries.select{|file| file.include? youtube_video.title.split('.').first}.first
  		new_file_name = file_name.gsub(/[^0-9A-Za-z]/, '')
  		File.rename("#{destiny_folder}/#{file_name}",new_file_name)
  		FileUtils.mv(new_file_name, destiny_folder)
	end

	def self.process_video(youtube_video)
		self.split_into_frames(youtube_video)
		self.get_soundtrack(youtube_video)		
	end

	def self.increase_reproduction_count(video_id)
		video = Video.find_by(:id => video_id)
		video.reproduction_count = video.reproduction_count + 1
		video.save
	end	 

	private
		def self.create_screenshot(video)
			@movie = FFMPEG::Movie.new(video.video.path)

			#en el nombre mismo de screenshot le pongo la ruta (asi me ahorro el paso de indicarsela explicitamente) 
			#  ejemplo: "/home/wizarmon/Documentos/mi_screenshot.jpg" 
			@screenshot = @movie.screenshot("#{Rails.root}/screenshots/#{video.title}_screenshot.jpg", 
				seek_time: @movie.duration/2, resolution: '320x240')
			# Asocio el screenshot al video
			@image = Image.create(:video_id => @video.id, 
				:image => File.new("#{Rails.root}/screenshots/#{video.title}_screenshot.jpg","r"))
			@image.url = @image.image.url
			@image.save

			# seteo la preview del video
			video.url_preview = @image.url
			video.save
		end

		def self.set_title(youtube_video)
		  	# @aux_title = system "viddl-rb #{youtube_video.url} -t"

		  	# # le asigno el titulo sin la extensión	
		  	# youtube_video.title = @aux_title.split('.').first
		  	raw_title_elements = ViddlRb.get_names(youtube_video.url).first.split('.')
		  	youtube_video.title = raw_title_elements.first
		  	youtube_video.format = raw_title_elements.last
  		end

  		def self.split_into_frames(youtube_video)
			video_directory = self.get_video_directory(youtube_video)
			src_file = self.get_source_file(youtube_video)
			aux_title = youtube_video.title.gsub(/[^0-9A-Za-z]/, '')
			system "ffmpeg -i #{src_file} -r 25 -qscale:v 2 #{video_directory}/#{aux_title}%d.jpg"
		end

		def self.get_soundtrack(youtube_video)
			video_directory = self.get_video_directory(youtube_video)
			src_file = self.get_source_file(youtube_video)
			aux_title = youtube_video.title.gsub(/[^0-9A-Za-z]/, '') + "SoundTrack" + "." + MP3_FILE_EXTENTION
			system "ffmpeg -i #{src_file} #{video_directory}/#{aux_title}"
		end

		def self.get_video_directory(youtube_video)
			@@videos_base_directory + "/" + youtube_video.title.gsub(/[^0-9A-Za-z]/, '') + "/"
		end

=begin
			TODO: arreglar este metodo
			para sliptear el video va bien, porque toma el primer video de la carpeta,
			pero al momento de procesar el audio falla dado que ahora tengo cientos de archivos donde antes
			habia solo uno.
			Tratar de adaptarlo para que cumpla ambos casos
=end	
		def self.get_source_file(youtube_video)
			video_directory = self.get_video_directory(youtube_video)

			return video_directory + Dir.new(video_directory).entries.select{|file| file.include? youtube_video.title.slice(0)}.first
		end
end