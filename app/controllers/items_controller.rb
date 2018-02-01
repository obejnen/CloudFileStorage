class ItemsController < ApplicationController
    before_action :set_item, only: [:destroy]
    before_action :set_folder, except: [:destroy]
    before_action :set_items, except: [:destroy]
    
    # def create
    #     files = params.require(:item).permit(file: [])[:file]
    #     files.each do |file|
    #         @folder.items.create(name: file.original_filename, user_id: current_user.id, folder_id: @folder.id, file: file)
    #     end
    # end

    def create
        @item = Item.new(item_params)
        if @item.save!
            respond_to do |format|
                format.json{ render :json => @item }
            end
        end
    end

    def destroy
        @item.destroy
        redirect_back fallback_location: root_path
    end

    def share_with
        @user = User.find_by_username(params[:username])
        @item = Item.find(params[:item])
        if @user && @item && has_access(@user, @item)
            @user.items << @item
        end
    end

    private
    
    def item_params
        @filename = params[:file].original_filename
        # @item = Item.new(file: params[:file], user_id: current_user.id, folder_id: @folder.id, name: @filename)
        params.permit().merge(user_id: current_user.id, folder_id: @folder.id, name: @filename, file: params[:file], encrypted_name: encrypt_name(@filename))
    end

    def encrypt_name(name)
        key = AES.key
        AES.encrypt(name, key)
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

    def set_item
        @item = Item.find(params[:id])
    end
end