if (@user and @video)
	json.user_id @user.id
	json.video_id @video.id
	json.title @video.title
	json.description @video.description
	json.url @video.url
	json.message "el video se ha creado correctamente"
else
	json.message "Error al subir el video"
end