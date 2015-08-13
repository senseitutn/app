class ChangeIdFacebookToFacebookIdUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :id_facebook, :facebook_id
  end
end
