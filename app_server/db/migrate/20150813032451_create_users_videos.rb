class CreateUsersVideos < ActiveRecord::Migration
  def change
    create_table :users_videos do |t|
    	t.column :users_id, :integer
    	t.column :videos_id, :integer
    end
  end
end
