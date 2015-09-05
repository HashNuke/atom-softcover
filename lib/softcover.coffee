SoftcoverView = require './softcover-view'
{CompositeDisposable} = require 'atom'

module.exports = Softcover =
  softcoverView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @softcoverView = new SoftcoverView(state.softcoverViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @softcoverView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'softcover:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @softcoverView.destroy()

  serialize: ->
    softcoverViewState: @softcoverView.serialize()

  toggle: ->
    console.log 'Softcover was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
