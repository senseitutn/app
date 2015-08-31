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
				# TODO: crear video con todos los parametros y asociarle una imagen usando streamio-ffmpeg y paperclip
				respond_with Video.create(params[:video])
			end

			def update
				respond_with Video.update(params[:id], params[:videos])
			end

			def destroy
				respond_with Video.destroy(params[:id])
			end

			def search_all
				@text = params[:text]
				@videos = Video.where("title LIKE ? OR description LIKE ?", "%#{@text}%","%#{@text}%")
			end

			# Customs methods
			def get_by_ranking
				#TODO: get_by_ranking
			end

			def get_recents
				#TODO: testear este metodo en consola
				@start = Date.today

				if(params[:ago] == 'days')
					@end = @start - params[:days]
				elsif(params[:ago] == 'week')
					@end = @start - 7
				elsif (params[:ago]== 'month') 
					@end = @start - 30
				else
					@end = nil
				end

				if @end
					@videos = Video.find(:all, :conditions =>{:created_at => @start..@end}).order("created_at desc")
				else
					#traemos los 10 mas recientes
					@videos = Video.order("created_at desc").limit(10)
				end
			end

			private
			def video_params
				params.require(:video).permit(:title,:url,:description,:duration,:uploaded_at,:video)
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