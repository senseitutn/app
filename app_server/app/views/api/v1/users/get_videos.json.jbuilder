json.videos @user.videos do |video|
	json.id video.id
	json.title video.title
	json.description video.description
	json.url_preview video.url_preview
end