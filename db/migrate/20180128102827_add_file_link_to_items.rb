class AddFileLinkToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :file, :string
  end
end
