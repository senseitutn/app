if @found
	json.favourite_id @favourite.id
	json.user_id @favourite.user_id
	json.video_id @favourite.video_id
	json.favourited_at @favourite.favourited_at
	json.message 'el registro ya existe'
else
	json.favourite_id @favourite.id
	json.user_id @favourite.user_id
	json.video_id @favourite.video_id
	json.favourited_at @favourite.favourited_at
	json.message 'registro creado correctamente'
end