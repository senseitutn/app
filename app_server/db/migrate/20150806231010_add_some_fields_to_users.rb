class AddSomeFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_1, :string
    add_column :users, :mail_2, :string
    add_column :users, :mail_3_string, :string
    add_column :users, :cel_1, :string
    add_column :users, :cel_2, :string
    add_column :users, :birthday, :date
    add_column :users, :country, :string
    add_column :users, :sex, :string
  end
end
