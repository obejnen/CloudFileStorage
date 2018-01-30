App.folders = App.cable.subscriptions.create "FoldersChannel",
  collection: -> $('#folders_table')

  connected: ->
    setTimeout =>
      @followCurrentFolder()
    , 1000

  disconnected: ->

  followCurrentFolder: ->
    current_folder_id = @collection().data('folder-id')
    if current_folder_id
      @perform 'follow', folder_id: current_folder_id
    else
      @perform 'unfollow'

  received: (data) ->
    @collection().children().append(data['new_folder'])