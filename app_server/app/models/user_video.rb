class UserVideo < ActiveRecord::Base
	belong_to :user
	belong_to :video
end
