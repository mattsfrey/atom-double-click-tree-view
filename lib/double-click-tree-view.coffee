'use strict'

class DoubleClickTreeView
  activate: ->
    atom.packages.activatePackage('tree-view').then (treeViewPkg) =>
      @treeView = treeViewPkg.mainModule.createView()
      @treeView.originalEntryClicked = @treeView.entryClicked

      @treeView.entryClicked = (e) ->
        false

      @treeView.on 'dblclick', '.entry', (e) =>
        @treeView.openSelectedEntry.call(@treeView)
        false

  deactivate: ->
    @treeView.entryClicked = @treeView.originalEntryClicked
    delete @treeView.originalEntryClicked
    @treeView.off 'dblclick', '.entry'

  entryDoubleClicked: (e) ->
    @originalEntryClicked(e)

module.exports = new DoubleClickTreeView()
