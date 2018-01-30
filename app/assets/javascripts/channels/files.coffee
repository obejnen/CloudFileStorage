App.files = App.cable.subscriptions.create "FilesChannel",
  connected: ->
    setTimeout =>
      @followCurrentFolder()
    , 1000

  disconnected: ->

  speak: (folder) ->
    @perform 'speak', folder: folder

  collection: -> $('#items_table')


  followCurrentFolder: ->
    folderId = @collection().data('folder-id')
    if folderId
      @perform 'follow', folder_id: folderId
    else
      @perform 'unfollow'

  received: (data) ->
    alert data['folder']
    @collection().append(data['folder'])
