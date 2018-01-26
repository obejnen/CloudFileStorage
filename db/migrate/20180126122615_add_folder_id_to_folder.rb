class AddFolderIdToFolder < ActiveRecord::Migration[5.1]
  def change
    add_column :folders, :folder_id, :integer
    add_index :folders, :folder_id
    add_column :items, :folder_id, :integer
    add_index :items, :folder_id
  end
end
