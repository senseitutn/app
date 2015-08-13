class ChangeBigIntToIntegerUsers < ActiveRecord::Migration
  def change
  	change_column :users, :id_facebook, :integer
  end
end
