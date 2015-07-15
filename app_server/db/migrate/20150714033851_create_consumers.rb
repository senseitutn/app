class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :token_fb
      t.string :image_url
      t.string :mail_1
      t.string :mail_2
      t.string :mail_3
      t.string :cel_1
      t.string :cel_2
      t.date :birthday
      t.string :country
      t.string :sex

      t.timestamps null: false
    end
  end
end
