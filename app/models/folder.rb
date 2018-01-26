class Folder < ApplicationRecord
    # belongs_to :owner, class_name: "User", foreign_key: "user_id"
    has_many :folder_shares
    has_many :users, through: :folder_shares
    belongs_to :owner, class_name: "User", foreign_key: "user_id"
    has_many :folders
    has_many :items

    # after_create_commit { RenderCommentJob.perform_later self }

end