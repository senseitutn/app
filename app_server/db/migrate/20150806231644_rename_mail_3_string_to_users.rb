class RenameMail3StringToUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :mail_3_string, :mail_3
  end
end