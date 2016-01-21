Polymer
  is: 'solitare-single-suit'

  ready: () ->
    $(this.$$ '#openedCards').droppable drop: (e, ui) ->
      oldCard = ui.draggable.parent()
      suit = oldCard.attr 'suit'
      value = oldCard.attr 'value'

      drag = false
      topmostCard = $(this).find 'solitare-card:last'
      if topmostCard.length
        if suit is (topmostCard.attr 'suit') and (parseInt value) - 1 is parseInt topmostCard.attr 'value'
          drag = true
      else
        if value is '1'
          drag = true

      if drag
        oldCard.detach()
        card = $('<solitare-card>').css('position', 'absolute').appendTo(this)[0];
        card.set suit, value
        card.openCard()