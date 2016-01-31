Polymer
    is: 'solitare-card-dropzone'

    ### @private ###
    _attributeChanged: (name, type) ->
        if name is 'disabled'
            this._observer()
        if name is 'accept'
            $(this).droppable "option", "accept", this.accept
        return

    ### @override ###
    attached: () ->
        $(this).droppable
            accept: this.accept
            create: (ev, ui) ->
                observer = new MutationObserver this._observer.bind(this)
                observer.observe this, childList:true
                this.attributeChanged = this._attributeChanged
                this._observer()
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
        if this.disabled is 'true'
            $(this).droppable 'disable'
        else
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
        console.log [this.tagName, {0:this}, msg]
        this

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
        disabled:
            type: String
            value: 'false'
            notify: true
            reflectToAttribute: true
        debug:
            type: String
            value: 'false'
            notify: true
            reflectToAttribute: true