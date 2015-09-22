class YoutubeVideo
	attr_accessor :url, :title, :format, :folder_name

	def get_folder
		return self.title.gsub(/\s/,'-') 
	end
end