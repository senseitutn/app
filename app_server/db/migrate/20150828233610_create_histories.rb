class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :video_id
      t.datetime :reproduced_at

      t.timestamps null: false
    end
  end
end
