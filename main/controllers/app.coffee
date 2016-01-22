window.addEventListener 'WebComponentsReady', () ->
  $("solitare-closed-deck")[0].addCard 'spades', 3
  $("solitare-closed-deck")[0].addCard 'spades', 1
  $("solitare-closed-deck")[0].addCard 'clubs', 1

  for i in [0..7]
    for j in [0..i]
      $("solitare-closed-stack")[i].addCard 'hearts', 7
