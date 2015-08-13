class ChangeBigIntegerToStringUsers < ActiveRecord::Migration
  def change
  	change_column :users, :id_facebook, :string
  end
end
