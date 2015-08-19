class RemoveIdFromUsersVideos < ActiveRecord::Migration
  def change
  	remove_column :users_videos, :id
  end
end
