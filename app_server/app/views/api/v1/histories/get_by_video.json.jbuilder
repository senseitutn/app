if @histories
	#json.message 'datos obtenidos correctamente'
	if @histories.length == 0
		json.message 'el video no tiene user histories asociadas'
	else
		json.array! (@histories) do |history|
			json.user_id history.user_id
			json.video_id history.video_id
			json.reproduced_at history.reproduced_at
		end
	end
elsif !@video
	json.message 'el video no existe'
else
	json.message 'el video no tiene user histories asociadas'
end
