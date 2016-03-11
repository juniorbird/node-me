nodeMeView = require './node-me-view'
{CompositeDisposable} = require 'atom'

module.exports = NodeMe =
  nodeMeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @nodeMeView = new nodeMeView(state.nodeMeViewState)
    @modalPanel = atom.workspace.addBottomPanel(item: @nodeMeView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'node-me:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @nodeMeView.destroy()

  serialize: ->
    nodeMeViewState: @nodeMeView.serialize()

  toggle: ->
    console.log 'Node-me was toggled developers!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText()
      console.log(words, 'words')
      @nodeMeView.setCount(words)
      @modalPanel.show()
