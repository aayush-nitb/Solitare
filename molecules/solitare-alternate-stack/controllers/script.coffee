Polymer
  is: 'solitare-alternate-stack'

  properties:
    value:
      type: Number
      notify: true
      reflectToAttribute: true
    suit:
      type: String
      notify: true
      reflectToAttribute: true

  ready: () ->
    $(this.$$ '#stack').draggable
      snap: true
      snapMode: 'inner'
      revert: true

    .droppable drop: (e, ui) ->
      oldStack = ui.draggable.parent()
      oldStack.appendTo this
