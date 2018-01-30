class RenderFolderJob < ApplicationJob
    queue_as :default
  
    def perform(folder)
      ActionCable.server.broadcast "files_channel", folder: render_folder(folder)
    end
  
    private

    def render_folder(folder)
      ApplicationController.renderer.render(partial: 'folders/folder', locals: { folder: folder })
      # ApplicationController.render_with_signed_in_user(folder.owner, partial: 'folders/folder', locals: { folder: folder })
    end
  end