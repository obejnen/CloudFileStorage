class FilesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "files_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # Folder.create(data['folder'])
    ActionCable.server.broadcast "files_channel", folder: data['folder']
  end
end
