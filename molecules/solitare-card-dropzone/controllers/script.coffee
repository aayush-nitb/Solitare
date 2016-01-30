Polymer
    is: 'solitare-card-dropzone'

    ### @override ###
    attached: () ->
        $(this).droppable
            accept: this.accept
            create: (ev, ui) ->
                observer = new MutationObserver this._observer.bind(this)
                observer.observe this, childList:true
                this.onReady()
                return
            activate: (ev, ui) ->
                this.onDraggableMotion ev, ui
                return
            deactivate: (ev, ui) ->
                this.onDraggableRest ev, ui
                return
            out: (ev, ui) ->
                this.onDraggableEscape ev, ui
                return
            over: (ev, ui) ->
                this.onDraggableOver ev, ui
                return
            drop: (ev, ui) ->
                suit = ui.draggable.attr 'suit'
                value = ui.draggable.attr 'value'
                if this._acceptor suit, value
                    ui.draggable.detach()
                    $(this).append ui.draggable
                    this.onDropAccept ev, ui
                else
                    this.onDropReject ev, ui
                return
        return
    
    ### @private ###
    _observer: (mutation) ->
        haveAnything = $(this).find('*').length
        if haveAnything
            $(this).droppable 'disable'
            this.log "is occupied and hence not droppable"
        else
            $(this).droppable 'enable'
            this.log "is empty and hence droppable"
        this

    ### @private ###
    _acceptor: (suit, value) ->
        true

    ### @public ###
    registerAcceptor: (acceptor) ->
        this._acceptor = acceptor
        this

    ### @public ###
    log: (msg) ->
        return if this.debug isnt 'true'
        console.log ["card-dropzone", {0:this}, msg]
        this

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