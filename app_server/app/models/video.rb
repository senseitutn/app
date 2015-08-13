class Video < ActiveRecord::Base
	#many to many relation with consumers model through favourites
	has_many :favourites
	has_many :users, through: :favourites

	#many to many relation with consumers model trough user_histories
	has_many :user_histories
	has_many :users, through: :user_histories

	has_and_belongs_to_many :users
	#many to many relation with consumers through consumer_videos
	# has_many :user_videos
	# has_many :users, through: :user_videos

	#to attach a video
	has_attached_file :video, :styles => {
	    :medium => { :geometry => "640x480", :format => 'mp4' },
	    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
	}, :processors => [:transcoder]
	#validation to attach a video
    validates_attachment_content_type :video, :content_type => ["video/mp4", "video.MOV", "video/mpeg","video/mpeg4"]
end
