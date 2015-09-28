class Favourite < ActiveRecord::Base
	belongs_to :user
	belongs_to :video

	validates :user_id, :uniqueness => {:scope => :video_id}
end
