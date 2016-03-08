WordcountWalkthroughView = require './wordcount-walkthrough-view'
{CompositeDisposable} = require 'atom'

module.exports = WordcountWalkthrough =
  wordcountWalkthroughView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @wordcountWalkthroughView = new WordcountWalkthroughView(state.wordcountWalkthroughViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @wordcountWalkthroughView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'wordcount-walkthrough:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @wordcountWalkthroughView.destroy()

  serialize: ->
    wordcountWalkthroughViewState: @wordcountWalkthroughView.serialize()

  toggle: ->
    console.log 'WordcountWalkthrough was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
