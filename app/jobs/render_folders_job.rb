class RenderFoldersJob < ApplicationJob
  queue_as :default

  def perform(folder)
  	ActionCable.server.broadcast "folder:#{folder.get_parent.id}", new_folder: render_folder(folder)
  end

  private

  def render_folder(folder)
  	ApplicationController.renderer.render(partial: "folders/folder", locals: { folder: folder })
  end
end
