class AddReproductionCountToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :reproduction_count, :integer
  end
end
