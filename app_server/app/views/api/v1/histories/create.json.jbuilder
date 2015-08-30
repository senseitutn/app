if @history
	json.history_id @history.id
	json.user_id @history.user_id
	json.video_id @history.video_id
	json.reproduced_at @history.reproduced_at
	json.message 'user history creada correctamente'
else
	json.message 'no se ha podido crear el registro'
end