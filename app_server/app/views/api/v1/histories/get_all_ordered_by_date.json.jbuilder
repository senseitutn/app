if @histories
	#json.message 'datos obtenidos correctamente'
	if not @histories.length == 0
		json.array! (@histories) do |history|
			json.history_id history.id
			json.user_id history.user_id
			json.video_id history.video_id
			json.reproduced_at history.reproduced_at
		end
	else
		json.message 'no hay user histories cargadas'
	end
else
	json.message 'no hay user histories cargadas'
end