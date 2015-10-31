class AddCheckedRejectedToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :checked, :boolean, default: false
    add_column :videos, :rejected, :boolean, default: false
  end
end