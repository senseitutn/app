class AddFramesCountToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :frames_count, :integer
  end
end
