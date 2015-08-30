if @favourite
	json.id @favourite.id
	json.user_id @favourite.user_id
	json.video_id @favourite.video_id
	json.favourited_at @favourite.favourited_at
	json.message 'el registro ya existe'
else
	@favourite = Favourite.create(:user_id => @user.id, :video_id => params[:video_id], :favourited_at => DateTime.now)

	json.id @favourite.id
	json.user_id @favourite.user_id
	json.video_id @favourite.video_id
	json.favourited_at @favourite.favourited_at
	json.message 'registro creado correctamente'
end