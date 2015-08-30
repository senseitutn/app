if @histories
	json.histories @histories do |history|
		json.user_id @history.user_id
		json.video_id @history.video_id
		json.reproduced_at @history.reproduced_at
	end
	json.message 'dados obtenidos correctamente'
else
	json.message 'el video no tiene user histories asociadas'
end