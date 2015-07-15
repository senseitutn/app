class Video < ActiveRecord::Base
	has_many :favourites
	has_many :consumers, :through => :favourites

	has_many :user_histories
	has_many :consumers, :through => :user_histories

	has_many :consumer_videos
	has_many :consumers, :through => :consumer_videos
end
