if not @videos.length == 0
	json.videos @videos do |video|
		json.id video.id
		json.title video.title
		json.description video.description
		json.url video.url
	end
else
	json.message "no hay videos subidos"
end