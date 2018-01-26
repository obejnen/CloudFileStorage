class CreateFolderShares < ActiveRecord::Migration[5.1]
  def change
    create_table :folder_shares do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :folder, foreign_key: true

      t.timestamps
    end
  end
end
