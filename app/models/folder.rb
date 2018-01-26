class Folder < ApplicationRecord
    # belongs_to :owner, class_name: "User", foreign_key: "user_id"
    has_many :folder_shares
    has_many :users, through: :folder_shares
    belongs_to :owner, class_name: "User", foreign_key: "user_id"
    belongs_to :parent, class_name: "Folder", foreign_key: "parent_id"
    has_many :folders
    has_many :items

    # after_create_commit { RenderCommentJob.perform_later self }

    def get_path(folder)
        unless folder.parent
            return folder.owner.username
        end
        return "#{get_path(folder.parent)}/#{folder.name}"
    end

end