Polymer
    is: 'solitare-card-dropzone'

    ready: () ->
        $(this).droppable drop: (e, ui) ->
            suit = ui.draggable.attr 'suit'
            value = ui.draggable.attr 'value'

            if this._acceptor suit, value
                ui.draggable.detach()
                $(this).replaceWith ui.draggable
    
    _acceptor: (suit, value) ->
        true

    registerAcceptor: (acceptor) ->
        this._acceptor = acceptor