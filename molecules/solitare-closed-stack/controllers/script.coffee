Polymer
  is: 'solitare-closed-stack'

  addCard: (suit, value) ->
    $('<solitare-card>').appendTo(this.$$ '#closedCards').css('height', 5)[0].set suit, value
