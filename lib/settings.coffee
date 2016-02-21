module.exports =
  config:
    a_apiKey:
      title: 'API key'
      type: 'string'
      default: ''
      description: 'Your pastery.net API key'
    b_expiration:
      title: 'Expiration time (in minutes)'
      type: 'integer'
      default: '1440'
      description: 'How long your past will last (-1 for unlimited)'
    c_views:
      title: 'Allowed views'
      type: 'integer'
      default: '-1'
      description: 'How many views you want to allow (-1 for unlimited)'
    d_injectToClipboard:
      title: 'Clipboard'
      type: 'boolean'
      default: true
      description: 'Inject the URL of the new paste to the clipboard'
    e_notification:
      title: 'Notification'
      type: 'boolean'
      default: true
      description: 'Shows an Atom notification when a paste is created'
    f_dismissAfter:
      title: 'Dismiss notification after'
      type: 'integer'
      default: 3
      description: 'If notification option is enabled, dismiss it after given seconds'
