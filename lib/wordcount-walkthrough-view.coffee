module.exports =
class WordcountWalkthroughView
  constructor: (serializedState) ->
    # Create root element
    @nodePanel = document.createElement('div')
    @nodePanel.classList.add('nodePanel')

    # Create nodeInstance nodePanel
    nodeInstance = document.createElement('div')
    nodeInstance.textContent = "Loading Node.js"
    nodeInstance.classList.add('nodejs')
    @nodePanel.appendChild(nodeInstance)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @nodePanel.remove()

  getElement: ->
    @nodePanel

  setCount: (count) ->
    displayText = "There are #{count} words."
    @nodePanel.children[0].textContent = displayText
