class AddFolderPathToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :folder_path, :string
  end
end
