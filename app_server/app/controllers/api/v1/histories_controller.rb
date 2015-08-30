module Api
	module V1
		class HistoriesController < ApplicationController
			# before_filter :restrict_acces
			skip_before_filter  :verify_authenticity_token
			respond_to :json

			def get_by_user
				# TODO: chequear esto
				@user = User.find_by(:facebook_id => params[:id_facebook])
				if @user
					@histories = History.where("user_id = #{@user.id}")
				end
			end

			def get_by_video
				# TODO: chequear esto
				@video = Video.find_by(:id => params[:video_id])
				if @video
					@histories = History.where("video_id = #{@video.id}")
				end
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