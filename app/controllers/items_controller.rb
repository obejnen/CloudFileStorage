class ItemsController < ApplicationController
    before_action :parse_files, only: [:create]
    before_action :set_folder
    before_action :set_items
    
    # def create
    #     files = params.require(:item).permit(file: [])[:file]
    #     files.each do |file|
    #         @folder.items.create(name: file.original_filename, user_id: current_user.id, folder_id: @folder.id, file: file)
    #     end
    # end

    def create
        @filename = params[:file].original_filename
        @item = Item.new(file: params[:file], user_id: current_user.id, folder_id: @folder.id, name: @filename)
        if @item.save!
            respond_to do |format|
                format.json{ render :json => @item }
            end
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