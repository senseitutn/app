module Api
	module V1
		class HistoriesController < ApplicationController
			# before_filter :restrict_acces
			skip_before_filter  :verify_authenticity_token
			respond_to :json

			def get_by_user
				# TODO: chequear esto
				@user = User.find_by(:facebook_id => params[:id_facebook])
				@histories = History.find_by(:user_id => @user.id)
			end

			def get_by_video
				# TODO: chequear esto
				@user = User.find_by(:facebook_id => params[:id_facebook])
				@histories = History.find_by(:user_id => @user.id)
			end

			def create
				# TODO: chequear
				@user = User.find_by(:facebook_id => params[:id_facebook])
				if @user
					@history = History.create(:user_id => @user.id, :video_id => params[:video_id],
					:reproduced_at => DateTime.now)
				end
			end
		end
	end
end