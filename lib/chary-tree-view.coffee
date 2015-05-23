'use strict'

class CharyTreeView
  activate: ->
    atom.packages.activatePackage('tree-view').then (treeViewPkg) =>
      @treeView = treeViewPkg.mainModule.createView()
      @treeView.originalEntryClicked = @treeView.entryClicked

      @treeView.entryClicked = (e) ->
        entry = e.currentTarget
        if entry.constructor.name == 'tree-view-file'
          false
        else
          @originalEntryClicked(e)

      @treeView.on 'dblclick', '.entry', (e) =>
        @treeView.openSelectedEntry.call(@treeView)
        false

  deactivate: ->
    @treeView.entryClicked = @treeView.originalEntryClicked
    delete @treeView.originalEntryClicked
    @treeView.off 'dblclick', '.entry'

  entryDoubleClicked: (e) ->
    @originalEntryClicked(e)

module.exports = new CharyTreeView()
