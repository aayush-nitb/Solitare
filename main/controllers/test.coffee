window.addEventListener 'WebComponentsReady', () ->
    holder = $("<solitare-alternate-stack>")[0].appendTo('body').set "open", "hearts", 1
    holder = $("<solitare-alternate-stack>")[0].appendTo(holder).set "open", "hearts", 2