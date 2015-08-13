class AddIdFacebookToUsers < ActiveRecord::Migration
	def up
    	add_column :users, :id_facebook, :big_integer
  	end

  	def down
    	remove_column :users, :id_facebook
  	end
end
