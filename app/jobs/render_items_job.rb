class RenderItemsJob < ApplicationJob
  queue_as :default

  def perform(item)
  	ActionCable.server.broadcast "folder:#{item.folder.id}", new_item: render_item(item)
  	puts item.folder.id
  end

  private

  def render_item(item)
  	ApplicationController.renderer.render(partial: "items/item", locals: { item: item })
  end
end
