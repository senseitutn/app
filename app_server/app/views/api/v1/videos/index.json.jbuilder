json.videos @user.videos do |video|
	json.id video.id
	json.title video.title
	json.description video.description
end
