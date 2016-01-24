window.addEventListener 'WebComponentsReady', () ->
    $("solitare-closed-deck")[0].addCard 'spades', 1
    $("solitare-closed-deck")[0].addCard 'clubs', 2
    $("solitare-closed-deck")[0].addCard 'clubs', 1

    for i in [0..7]
        holder = $("#secondRow solitare-deck-holder")[i]
        holder = $("<solitare-alternate-stack>")[0].appendTo(holder).set "close", "hearts", i+3
        holder = $("<solitare-alternate-stack>")[0].appendTo(holder).set "open", "spades", i+2
        holder = $("<solitare-alternate-stack>")[0].appendTo(holder).set "open", "diamonds", i+1
