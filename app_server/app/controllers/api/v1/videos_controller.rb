module Api
	module V1
		class VideosController < ApplicationController
			# before_filter :restrict_acces
			respond_to :json

			def index
				respond_with Video.all
			end

			def show
				respond_with Video.find(params[:id])
			end

			def create
				respond_with Video.create(params[:video])
			end

			def update
				respond_with Video.update(params[:id], params[:videos])
			end

			def destroy
				respond_with Video.destroy(params[:id])
			end

			# para el momento en el que necesitemos autenticar el acceso a recursos

			# private
			# def restrict_access
			# 	authenticate_or_request_with_http_token do |token, options|
			# 		ApiKey.exists?(access_token: token)
			# 	end
			# end
		end
	end
end