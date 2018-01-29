class ItemsController < ApplicationController
    before_action :parse_files, only: [:create]
    before_action :set_folder, only: [:create]
    
    def create
        files = params.require(:item).permit(file: [])[:file]
        files.each do |file|
            @folder.items.create(name: file.original_filename, user_id: current_user.id, folder_id: @folder.id, file: file)
        end
    end

    private

    def parse_files
        # files = params.require(:item).permit(:file)
    end

    def item_params
        # @name = params.require(:item).require(:file).original_filename
        params.require(:item).permit(:file).merge(user_id: current_user.id, folder_id: @folder.id, name: @name)
    end

    def set_folder
        @folder = current_user.own_folders.first
        @folder = Folder.find(params[:id]) if params.has_key?(:id)
        @folder = Folder.find(params[:folder_id]) if params.has_key?(:folder_id)
    end
end