PasteryView = require './pastery-view'
{CompositeDisposable} = require 'atom'

request = require 'request'

module.exports = Pastery =
  pasteryView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @pasteryView = new PasteryView(state.pasteryViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @pasteryView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'pastery:paste': => @paste()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @pasteryView.destroy()

  serialize: ->
    pasteryViewState: @pasteryView.serialize()

  paste: ->
    editor = atom.workspace.getActiveTextEditor()
    fileName = editor.getTitle()
    content = editor.getSelectedText() || editor.getText()

    request.post {
      qs:
        'title': fileName
      url: 'https://www.pastery.net/api/paste/'
      body: content
    }, (error, res, body) ->
      console.log 'Pastery.net response error', error
      console.log 'Pastery.net response body', body

      url = JSON.parse(body).url
      atom.clipboard.write(url)
      return
