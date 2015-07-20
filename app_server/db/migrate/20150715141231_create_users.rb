class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :name
      t.string :surname
      t.integer :failed_login_count
      t.datetime :disabled_at

      t.timestamps null: false
    end
  end
end
