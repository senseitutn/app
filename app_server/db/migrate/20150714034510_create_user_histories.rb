class CreateUserHistories < ActiveRecord::Migration
  def change
    create_table :user_histories do |t|
      t.integer :video_id
      t.integer :consumer_id
      t.datetime :last_reproduction
      t.integer :visits_count

      t.timestamps null: false
    end
  end
end
