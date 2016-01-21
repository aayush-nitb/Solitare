window.addEventListener 'WebComponentsReady', () ->
  $("solitare-closed-deck")[0].addCard 'spades', 3
  $("solitare-closed-deck")[0].addCard 'spades', 1
  $("solitare-closed-deck")[0].addCard 'clubs', 1