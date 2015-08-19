class RenameConsumerUserFavourite < ActiveRecord::Migration
  def change
  	rename_column :favourites, :consumer_id, :user_id
  end
end
