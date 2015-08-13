class RenameConsumerIdUserIdUserHistories < ActiveRecord::Migration
  def change
  	rename_column :user_histories, :consumer_id, :user_id
  end
end
