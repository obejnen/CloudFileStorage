class FilesController < ApplicationController
    def index
        @folders_search = current_user.own_folders.ransack(params[:q])
        @folders = @folders_search.result

        @items_search = current_user.own_items.ransack(params[:q])
        @items = @items_search.result
    end
end