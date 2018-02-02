class ItemsController < ApplicationController
    # before_action :set_item, only: [:destroy, :check_for_access]
    before_action :set_folder, except: [:destroy, :check_for_access]
    before_action :set_items, except: [:destroy]
    
    def create
        @new_item = Item.new(item_params)
        @old_item = find_replace(@new_item)
        if @new_item.save!
            if @old_item
                @old_item.delete
            end
            respond_to do |format|
                format.json{ render :json => @item }
            end
        end
    end

    def destroy
        if params.has_key?(:folder_id)
            @item = Item.find(params[:folder_id])
            @folder = Folder.find_by_id(params[:id]) if params.has_key?(:id)            
        else
            @item = Item.find(params[:id])
            @folder = current_user.own_folders.first
        end
        # @folder = Folder.find(params[:folder_id]) if params.has_key?(:folder_id)      
        if has_access(@item, @folder)
            @item.destroy
        end
    end

    def share_with
        @user = User.find_by_username(params[:username])
        @item = Item.find(params[:item])
        if @user && @item && has_access(@user, @item)
            @user.items << @item
        end
    end

    private

    def find_replace(item)
        @folder.items.find_by_name(item.name)
    end
    
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
        @folder = Folder.find_by_id(params[:id]) if params.has_key?(:id)
        @folder = Folder.find(params[:folder_id]) if params.has_key?(:folder_id)
    end

    def set_item
        @item = Item.find(params[:id])
    end

    def has_access(item, folder)
        item.owner == current_user || folder.owner == current_user
    end
end