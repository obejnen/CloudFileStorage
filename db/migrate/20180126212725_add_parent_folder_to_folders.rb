class AddParentFolderToFolders < ActiveRecord::Migration[5.1]
  def change
    add_column :folders, :parent_id, :integer
    add_index :folders, :parent_id
  end
end