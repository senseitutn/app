class ChangeIntegerToBigIntegerUsers < ActiveRecord::Migration
  def change
  	change_column :users, :id_facebook, :big_integer
  end
end
