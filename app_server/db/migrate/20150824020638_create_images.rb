class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.references :video, index: true

      t.timestamps null: false
    end
    add_foreign_key :images, :videos
  end
end
