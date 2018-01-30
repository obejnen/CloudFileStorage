class Item < ApplicationRecord
    after_create_commit { RenderItemsJob.perform_later self }
    has_many :item_shares
    has_many :items, through: :item_shares
    belongs_to :folder
    belongs_to :owner, class_name: "User", foreign_key: "user_id"
    mount_uploader :file, FileUploader
end
