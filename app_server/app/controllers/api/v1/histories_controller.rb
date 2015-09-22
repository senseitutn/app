module Api
	module V1
		class HistoriesController < ApplicationController
			# before_filter :restrict_acces
			skip_before_filter  :verify_authenticity_token
			respond_to :json

			def get_by_user
				@user = User.find_by(:facebook_id => params[:id_facebook])
				if @user
					@histories = History.where("user_id = #{@user.id}")
				end
			end

			def get_by_video
				@video = Video.find_by(:id => params[:video_id])
				if @video
					@histories = History.where("video_id = #{@video.id}")
				end
			end

			#TODO: testear
			def get_all_ordered_by_date
				@histories = History.order("reproduced_at desc")
			end

			#TODO: testear
			def get_by_user_ordered_by_date
				@user = User.find_by(:facebook_id => params[:id_facebook])
				@histories = History.where("user_id = #{@user.id}").order("reproduced_at desc")
			end

			def create
				@user = User.find_by(:facebook_id => params[:id_facebook])
				if @user
					@history = History.create(:user_id => @user.id, :video_id => params[:video_id],
					:reproduced_at => DateTime.now)
					VideoService.increase_reproduction_count(params[:video_id])
				end
			end
		end
	end
end