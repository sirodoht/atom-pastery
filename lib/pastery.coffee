{CompositeDisposable} = require 'atom'

request = require 'request'

PasteryView = require './pastery-view'
settings = require './settings'

module.exports = Pastery =
  config: settings.config

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
    apiKey = atom.config.get('pastery.apiKey')

    qs = {}
    qs.title = fileName
    if apiKey
      qs.api_key = apiKey

    request.post {
      qs: qs
      url: 'https://www.pastery.net/api/paste/'
      body: content
    }, (error, res, body) ->
      console.log 'Pastery.net response error', error
      console.log 'Pastery.net response body', body

      if atom.config.get('pastery.injectToClipboard')
        url = JSON.parse(body).url
        atom.clipboard.write(url)
      return
