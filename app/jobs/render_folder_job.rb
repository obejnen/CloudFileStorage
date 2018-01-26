class RenderFolderJob < ApplicationJob
    queue_as :default
  
    def perform(folder)
      ActionCable.server.broadcast "article:#{comment.article_id}:comments", foo: render_comment(comment)
    end
  
    private
      def render_comment(comment)
        ApplicationController.renderer.render(partial: 'comments/comment', locals: { comment: comment })
      end
  end