class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :path
      t.text :description
      t.float :duration
      t.date :uploaded_at

      t.timestamps null: false
    end
  end
end
