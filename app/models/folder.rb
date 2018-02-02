class Folder < ApplicationRecord
    after_create_commit { RenderFoldersJob.perform_later self }
    validates :name, presence: true
    has_many :folder_shares
    has_many :users, through: :folder_shares
    belongs_to :owner, class_name: "User", foreign_key: "user_id"
    has_one :parent, class_name: "Folder", foreign_key: "parent_id"
    has_many :folders, dependent: :destroy
    has_many :items

    require 'aes'


    def get_path(folder)
        path = ""
        while folder
            temp_path = "<span class='path-link'><a href='/folders/#{folder.id}'>#{folder.name}</a></span>"
            path = path == "" ? temp_path : temp_path + " &rarr; #{path}"
            folder = folder.get_parent
        end
        return path
    end

    def get_hash_path(folder)
        hash_path = Hash.new
        while folder
            hash_path[folder.name] = folder.id
            folder = folder.get_parent
        end
        return hash_path
    end

    def get_parent
        return self.parent_id ? Folder.find(self.parent_id) : nil
    end

end