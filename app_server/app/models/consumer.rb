class Consumer < ActiveRecord::Base
	has_many :favoutires
	has_many :videos, :through => :favoutires

	has_many :user_histories
	has_many :videos, :through => :user_histories

	has_many :consumer_videos
	has_many :videos, :through => :consumer_videos
end
