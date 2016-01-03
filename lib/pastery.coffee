{CompositeDisposable} = require 'atom'

request = require 'request'

settings = require './settings'

module.exports = Pastery =
  config: settings.config
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'pastery:paste': => @paste()

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

      url = JSON.parse(body).url
      if atom.config.get('pastery.injectToClipboard')
        atom.clipboard.write(url)

      msg = 'You can see your paste at ' + url
      atom.notifications.addInfo('Paste created!', detail: msg, dismissable: true)

      return
