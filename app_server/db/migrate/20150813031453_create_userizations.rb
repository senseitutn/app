class CreateUserizations < ActiveRecord::Migration
  def change
    create_table :userizations do |t|
      t.references :video, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :userizations, :videos
    add_foreign_key :userizations, :users
  end
end
