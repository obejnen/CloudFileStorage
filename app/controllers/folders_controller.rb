class FoldersController < ApplicationController
    before_action :set_folder #, only: [:show, :create, :new, :index]
    before_action :set_items
    before_action :set_shared, only: [:show_shared]

    def create
        # new_folder = Folder.new(folder_params)
        # new_folder.parent = @folder
        # @folder.folders << new_folder
        @folder.folders.create(folder_params)
    end

    def index
    end

    def show
    end

    def show_shared
    end

    def show_root_folder
        @folders_search = current_user.own_folders.first.folders.ransack(params[:q])
        @folders = @folders_search.result

        @items_search = current_user.own_folders.first.items.ransack(params[:q])
        @items = @items_search.result
    end

    private

    def set_shared
        @folders_search = current_user.folders.ransack(params[:q])
        @folders = @folders_search.result

        @items_search = current_user.items.ransack(params[:q])
        @items = @items_search.result
    end

    def folder_params
        params.require(:folder).permit(:name).merge(user_id: current_user.id, parent_id: @folder.id)
    end

    def set_items
        @folders_search = @folder.folders.ransack(params[:q])
        @folders = @folders_search.result

        @items_search = @folder.items.ransack(params[:q])
        @items = @items_search.result
    end

    def set_folder
        @folder = current_user.own_folders.first
        @folder = Folder.find(params[:id]) if params.has_key?(:id)
        @folder = Folder.find(params[:folder_id]) if params.has_key?(:folder_id)
    end

end