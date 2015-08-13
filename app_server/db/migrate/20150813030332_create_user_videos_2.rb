class CreateUserVideos2 < ActiveRecord::Migration
  def change
    create_table :user_videos do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :video, index:true
      	t.timestamps null: false
    end
  end
end

