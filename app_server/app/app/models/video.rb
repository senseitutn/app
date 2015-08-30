class Video < ActiveRecord::Base
	#many to many relation with consumers model through favourites
	has_many :favourites
	has_many :users, through: :favourites

	#many to many relation with consumers model trough user_histories
	has_many :histories
	has_many :users, through: :histories

	has_and_belongs_to_many :users
	#many to many relation with consumers through consumer_videos
	# has_many :user_videos
	# has_many :users, through: :user_videos

	# to attach a image preview => I created that like another class with a belongs_to association
	has_one :image

	#to attach a video
	has_attached_file :video, :styles => {
	    :medium => { :geometry => "640x480", :format => 'mp4' },
	    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
	}, :processors => [:transcoder]
	#validation to attach a video
    validates_attachment_content_type :video, :content_type => ["video/mp4", "video.MOV", "video/mpeg","video/mpeg4"]

    # def create_video(params)
    # 	video = Video.new

    # 	video.title = params.title
    # 	video.description = params.description
    # 	video.url = params.video.url
    # 	video.video = params.video
    # 	video.uploaded_at = DateTime.now
    # 	video.save!
    # end
end
