class AddEncryptedNameToFolders < ActiveRecord::Migration[5.1]
  def change
    add_column :folders, :encrypted_name, :string
  end
end
