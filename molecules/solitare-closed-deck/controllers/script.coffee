Polymer
  is: 'solitare-closed-deck'

  ready: () ->
    openedCards = this.$$ '#openedCards'
    closedCards = this.$$ '#closedCards'

    $(closedCards).click () ->
      topmostCard = $(this).find('solitare-card:last')
      if topmostCard.length
        topmostCard.detach().appendTo(openedCards)[0].openCard()
      else
        $(openedCards).find('solitare-card').each () ->
          $(this).detach().prependTo(closedCards)[0].closeCard()

  addCard: (suit, value) ->
    $('<solitare-card>').appendTo(this.$$ '#closedCards').css("position", "absolute")[0].set suit, value