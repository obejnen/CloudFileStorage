App.folders = App.cable.subscriptions.create "FoldersChannel",
  # connected: ->
    # Called when the subscription is ready for use on the server
  connected: ->
    setTimeout =>
      @followCurrentFolder()
    , 1000

  disconnected: ->
    # Called when the subscription has been terminated by the server

  speak: (folder) ->
    alert(folder)
    @perform 'speak', folder: folder

  collection: -> $('#items_table')


  followCurrentFolder: ->
    folderId = @collection().data('folder-id')
    if folderId
      @perform 'follow', folder_id: folderId
    else
      @perform 'unfollow'

  received: (data) ->
    alert(data['folder'])
    @collection().append(data['folder'])