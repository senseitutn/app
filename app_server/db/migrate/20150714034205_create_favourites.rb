class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :video_id
      t.integer :consumer_id
      t.datetime :favourited_at

      t.timestamps null: false
    end
  end
end
