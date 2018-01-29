class FoldersChannel < ApplicationCable::Channel
    def subscribed
      stream_from "folders_channel"
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  
    def speak(data)
      ActionCable.server.broadcast 'folders_channel', folder: data['folder']
    end
  
    def follow(params)
      stop_all_streams
      stream_from "folder:#{params['folder_id'].to_i}:folders"
    end
  
    def unfollow
      # stop_all_streams
    end
  end
  