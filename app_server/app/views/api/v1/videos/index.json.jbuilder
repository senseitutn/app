json.videos @videos do |video|
	json.id video.id
	json.title video.title
	json.description video.description
	json.url video.url
end
