class ItemsChannel < ApplicationCable::Channel
  def follow(params)
    stop_all_streams
    stream_from "folder:#{params['folder_id'].to_i}"
  end

  def unfollow
    stop_all_streams
  end
end
