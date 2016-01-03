module.exports =
  config:
    apiKey:
      title: 'API key'
      type: 'string'
      default: ''
      description: 'Your pastery.net API key'
    injectToClipboard:
      title: 'Clipboard'
      type: 'boolean'
      default: true
      description: 'Inject the URL of the new paste to the clipboard'
    notification:
      title: 'Notification'
      type: 'boolean'
      default: true
      description: 'Shows an Atom notification when a paste is created'
    dismissAfter:
      title: 'Dismiss notification after'
      type: 'integer'
      default: 3
      description: 'If notification option is enabled, dismiss it after given seconds'
