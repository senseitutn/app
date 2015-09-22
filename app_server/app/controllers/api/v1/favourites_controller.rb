module Api
	module V1
		class FavouritesController < ApplicationController
			# before_filter :restrict_acces
			skip_before_filter  :verify_authenticity_token
			respond_to :json

			#Specific methods for this server
			def get_all_with_user
				@user = User.find_by(:facebook_id => params[:id_facebook])
				@favourites = Favourite.where("user_id = #{@user.id}")
			end

			def get_all_with_video
				@video = Video.find_by(params[:video_id])
				@favourites = Favourite.where("video_id = #{@video.id}")
			end

			def create
				@user = User.find_by(:facebook_id => params[:id_facebook])
				@favourite = Favourite.create(:video_id => params[:video_id], :user_id => @user.id, :favourited_at => DateTime.now)
			end
		end
	end
end