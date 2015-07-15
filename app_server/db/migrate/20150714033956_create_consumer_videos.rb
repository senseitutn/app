class CreateConsumerVideos < ActiveRecord::Migration
  def change
    create_table :consumer_videos do |t|
      t.integer :video_id
      t.integer :consumer_id

      t.timestamps null: false
    end
  end
end
