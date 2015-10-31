module Api
	module V1
		class UsersController < ApplicationController
			# before_filter :restrict_access, excepts: [:show, :create]
			skip_before_filter  :verify_authenticity_token
			respond_to :json

			def index
				respond_with User.all
			end

			def show
				respond_with User.find(params[:id_facebook])
			end

			def create
				@user = User.new(:username => params[:name], :name => params[:first_name], :surname => params[:last_name], 
					:facebook_id => params[:facebook_id])
				@user.save
			end

			def update
				#respond_with User.update(params[:id], params[:videos])
			end

			def destroy
				respond_with User.destroy(params[:id])
			end

			def get_user
				respond_with User.find_by(:facebook_id => params[:id_facebook])
			end

			def get_videos
				@user = User.find_by(:facebook_id => params[:id_facebook])
				@videos = @user.videos.order("uploaded_at desc")
			end

			def create_video
				@user = User.find_by(:facebook_id => params[:id_facebook])

				title = params[:title]

				video_folder_entry = Dir.new(DOWNLOADED_VIDEOS_FOLDER).entries.select{|file| file.include? title.slice(4)}.first
				folder_video =  DOWNLOADED_VIDEOS_FOLDER + "/" + video_folder_entry
				frames_count = Dir.new(folder_video).entries.count - 4

				@video = @user.videos.create(:title => params[:title], 
					:description => params[:description] , :folder_path => video_folder_entry, 
					:frames_count => frames_count, :url => params[:url], 
					:uploaded_at => DateTime.now)
			end

			#Get the user favourites
			def favourites
				@user = User.find_by(:facebook_id => params[:id_facebook])
				@favourites = Favourite.where("user_id = #{@user.id}")
			end

			private 
			def user_params
				params.require(:user).permit(:name, :first_name, :last_name, :email, :gender, :birthday)
			end

			def restrict_access
				authenticate_or_request_with_http_token do |token, options|
					ApiKey.exists?(access_token: token)
				end
			end

=begin
			#Esto no se va a usar

			def handle_tokens
				@graph = Koala::Facebook::API.new(params[:token_fb])
				@user = User.find_by(name: @graph.get_object("me").name)
				if @user
					render json: @user.as_json(only: [@user_id, @user.api_key]) 
				else

					# 1) se debe redirigir al metodo create de este mismo controller
					# 2) una vez creado responder con el json
					@user = User.new
					@user = User.create_from_graph(:graph => @graph, :user => @user)
					if @user
						@access_token = ApiKey.create(:user_id => @user.id)
						respond_with @user
					else
						render :json => { :errors => @user.errors.as_json }, :status => 420
					end
				end
			end
=end

		end
	end
end