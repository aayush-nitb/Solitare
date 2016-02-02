window.addEventListener 'WebComponentsReady', () ->
    console.log "WebComponentsReady"
    $("#allowSameColor")[0].registerAcceptor (drag, drop) ->
        return true if drag.color() is drop.color()
        return false