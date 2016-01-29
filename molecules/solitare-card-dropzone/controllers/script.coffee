Polymer
    is: 'solitare-card-dropzone'

    ### @override ###
    ready: () ->
        $(this).droppable
            accept: this.accept
            activate: (ev, ui) ->
                this.onDraggableMotion ev, ui
            deactivate: (ev, ui) ->
                this.onDraggableRest ev, ui
            out: (ev, ui) ->
                this.onDraggableEscape ev, ui
            over: (ev, ui) ->
                this.onDraggableOver ev, ui
            drop: (ev, ui) ->
                suit = ui.draggable.attr 'suit'
                value = ui.draggable.attr 'value'
                if this._acceptor suit, value
                    ui.draggable.detach()
                    $(this).replaceWith ui.draggable
                    this.onDropAccept ev, ui
                else
                    this.onDropReject ev, ui
        this.onReady()
    
    ### @private ###
    _acceptor: (suit, value) ->
        true

    ### @public ###
    registerAcceptor: (acceptor) ->
        this._acceptor = acceptor

    ### @event ###
    onReady: () ->
        return

    ### @event ###
    onDropAccept: (ev, ui) ->
        return

    ### @event ###
    onDropReject: (ev, ui) ->
        return

    ### @event ###
    onDraggableMotion: (ev, ui) ->
        return

    ### @event ###
    onDraggableRest: (ev, ui) ->
        return

    ### @event ###
    onDraggableEscape: (ev, ui) ->
        return

    ### @event ###
    onDraggableOver: (ev, ui) ->
        return

    properties:
        accept:
            type: String
            value: 'solitare-card'
            notify: true
            reflectToAttribute: true