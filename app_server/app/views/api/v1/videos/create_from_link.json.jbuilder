if !@msj
	json.video_id	@video.id
	json.video_title @youtube_video.title
	json.user @user.id
	json.video_path @youtube_video.folder_path
	json.message "video descargado correctamente"
else
	json.message @msj
end