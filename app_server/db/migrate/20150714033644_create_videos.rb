class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :url
      t.text :description
      t.string :url_preview
      t.datetime :uploaded_at

      t.timestamps null: false
    end
  end
end
