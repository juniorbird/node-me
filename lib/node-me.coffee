nodeMeView = require './node-me-view'
{CompositeDisposable} = require 'atom'
Terminal = require 'term.js'
child_process = require('child_process')
path = require 'path'
fs = require 'fs'
spawn = require('child_process').spawn

module.exports = NodeMe =
  nodeMeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @ls = spawn('ls', ['-lh', '/usr'])
    console.log(@ls)

    @ls.stdout.on('data', (data) =>
      console.log('data', data)
    )

    @ls.stderr.on('data', (data) =>
      console.log('error', data);
    )

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
    console.log(@ls)

    if @modalPanel.isVisible()
      @modalPanel.hide()
      console.log(ls)
    else
      editor = atom.workspace.getActiveTextEditor()
      code = editor.getText()
      @nodeMeView.setCode(code)
      @modalPanel.show()
