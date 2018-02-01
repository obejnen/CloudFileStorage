class AddEncryptedNameToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :encrypted_name, :string
  end
end
