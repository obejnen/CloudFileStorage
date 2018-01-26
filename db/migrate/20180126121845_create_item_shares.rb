class CreateItemShares < ActiveRecord::Migration[5.1]
  def change
    create_table :item_shares do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :item, foreign_key: true

      t.timestamps
    end
  end
end
