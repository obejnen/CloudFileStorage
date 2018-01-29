class Folder < ApplicationRecord
    after_create_commit { RenderFolderJob.perform_later self }
    # belongs_to :owner, class_name: "User", foreign_key: "user_id"
    has_many :folder_shares
    has_many :users, through: :folder_shares
    belongs_to :owner, class_name: "User", foreign_key: "user_id"
    has_one :parent, class_name: "Folder", foreign_key: "parent_id"
    has_many :folders
    has_many :items


    def get_path(folder)
        path = ""
        while folder
            temp_path = "<a href='/folders/#{folder.id}'>#{folder.name}</a>"
            path = path == "" ? temp_path : temp_path + " / #{path}"
            folder = folder.get_parent
        end
        return path
    end

    def get_parent
        return self.parent_id ? Folder.find(self.parent_id) : nil
    end

end