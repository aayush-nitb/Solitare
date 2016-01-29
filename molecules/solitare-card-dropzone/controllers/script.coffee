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

    ### @public ###
    log: (msg) ->
        return if this.debug isnt 'true'
        console.log ["card-dropzone", {0:this}, msg]

    ### @event ###
    onReady: () ->
        this.log "fired default event: onReady"

    ### @event ###
    onDropAccept: (ev, ui) ->
        this.log "fired default event: onDropAccept"

    ### @event ###
    onDropReject: (ev, ui) ->
        this.log "fired default event: onDropReject"

    ### @event ###
    onDraggableMotion: (ev, ui) ->
        this.log "fired default event: onDraggableMotion"

    ### @event ###
    onDraggableRest: (ev, ui) ->
        this.log "fired default event: onDraggableRest"

    ### @event ###
    onDraggableEscape: (ev, ui) ->
        this.log "fired default event: onDraggableEscape"

    ### @event ###
    onDraggableOver: (ev, ui) ->
        this.log "fired default event: onDraggableOver"

    properties:
        accept:
            type: String
            value: 'solitare-card'
            notify: true
            reflectToAttribute: true
        debug:
            type: String
            value: 'false'
            notify: true
            reflectToAttribute: true