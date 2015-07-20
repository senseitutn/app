module Api
	module V1
		class UsersController < ApplicationController
			# before_filter :restrict_acces, excepts: :create
			skip_before_filter  :verify_authenticity_token
			respond_to :json

			def index
				respond_with User.all
			end

			def show
				respond_with User.find(params[:id])
			end

			def create
				@user = User.create(user_params)
				@access_token = ApiKey.create(:user_id => @user.id)
				respond_with @user
			end

			def update
				#respond_with User.update(params[:id], params[:videos])
			end

			def destroy
				respond_with User.destroy(params[:id])
			end

			private 
			def user_params
				params.require(:user).permit(:username, :password, :name, :surname)
			end

			# para el momento en que necesitemos autenticar el acceso a usuarios

			# def restrict_access
			# 	authenticate_or_request_with_http_token do |token, options|
			# 		ApiKey.exists?(access_token: token)
			# 	end
			# end
		end
	end
end