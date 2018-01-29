class RenderFolderJob < ApplicationJob
    queue_as :default
  
    def perform(folder)
      ActionCable.server.broadcast "folder:#{folder.folder_id}:folders", foo: render_folder(folder)
    end
  
    private

    def render_folder(folder)
      ApplicationController.renderer.render(partial: 'files/files_table', locals: { folder: folder })
      # ApplicationController.render_with_signed_in_user(folder.owner, partial: 'folders/folder', locals: { folder: folder })
    end
  end