class FoldersController < ApplicationController
    before_action :set_folder #, only: [:show, :create, :new, :index]
    before_action :set_items
    before_action :set_shared, only: [:show_shared]
    before_action :check_for_access, only: [:show]

    require 'aes'

    def create
        new_folder = Folder.new(folder_params)
        new_folder.parent = @folder
        unless @folder.folders.find_by_name(new_folder.name)
            @folder.folders.create(folder_params)
        end
            # @folder.folders.create(folder_params)
    end

    # def index
    # end

    def destroy
        destroy_inner(@folder)
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

    def share_with
        @user = User.find_by_username(params[:username])
        @folder = Folder.find(params[:folder])
        if @user && @folder && has_access(@user, @folder)
            @user.folders << @folder
            share_inner(@user, @folder)
        end
    end

    def edit
        @folder_to_rename = Folder.find(params[:folder])
        @folder = @folder_to_rename.get_parent
        @same_folder = @folder.folders.find_by_name(params[:foldername])
        if @same_folder
            @same_folder.items << @folder_to_rename.items
            @folder_to_rename.delete
        else
            @folder_to_rename.update(name: params[:foldername])
        end
    end


    private

    def destroy_inner(folder)
        folder.folders.each do |f|
            f.destroy_inner(f)
        end
        folder.items.each do |i|
            i.delete
        end
        folder.delete
    end

    def share_inner(user, folder)
        folder.folders.each do |f|
            user.folders << f
            share_inner(user, f)
        end
        folder.items.each do |i|
            user.items << i
        end
    end

    def check_for_access
        unless (@folder.owner == current_user || @folder.users.include?(current_user))
            not_found
        end
    end

    def set_shared
        @folders_search = current_user.folders.ransack(params[:q])
        @folders = @folders_search.result

        @items_search = current_user.items.ransack(params[:q])
        @items = @items_search.result
    end

    def folder_params
        name = params.require(:folder).permit(:name).require(:name)
        params.require(:folder).permit(:name).merge(user_id: current_user.id, parent_id: @folder.id, encrypted_name: encrypt_name(name))
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

end