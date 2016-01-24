window.addEventListener 'WebComponentsReady', () ->
    $("solitare-closed-deck")[0].addCard 'spades', 1
    $("solitare-closed-deck")[0].addCard 'clubs', 2
    $("solitare-closed-deck")[0].addCard 'clubs', 1