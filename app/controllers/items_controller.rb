class ItemsController < ApplicationController
    before_action :set_folder, only: [:create]
    
    def create
        Item.create(item_params)
    end

    private

    def item_params
        @name = params.require(:item).require(:file).original_filename
        params.require(:item).permit(:file).merge(user_id: current_user.id, folder_id: @folder.id, name: @name)
    end

    def set_folder
        @folder = current_user.own_folders.first
        @folder = Folder.find(params[:id]) if params.has_key?(:id)
        @folder = Folder.find(params[:folder_id]) if params.has_key?(:folder_id)
    end
end