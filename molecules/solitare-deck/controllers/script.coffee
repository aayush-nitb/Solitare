Polymer
    is: 'solitare-deck'

    ### @override ###
    attributeChanged: (name, type) ->
        if name is 'modifiers' or name is 'elements'
            this.setModifiers this.modifiers
        return

    ### @override ###
    ready: () ->
        observer = new MutationObserver this._observer.bind(this)
        observer.observe this,
            childList:true
            subtree:true
        return

    ### @private ###
    _observer: (mutation) ->
        deck = this
        elements = $(this).find(this.elements)
        this.log "has " + elements.length + " element(s)"
        modifierString = JSON.stringify this.modifiers
        this.log "modifiers: " + modifierString if modifierString and modifierString isnt '{}'
        this.log "applied registerAcceptor for child elements" if deck._acceptor
        elements.each () ->
            if deck._acceptor
                droppable = this
                this.dropzone().registerAcceptor (draggable) ->
                    return deck._acceptor(draggable, droppable)
            for modifier, value of deck.modifiers
                this[modifier] = value
        this.onChange elements
        return

    ### @public ###
    setModifiers: (modifiers) ->
        this.modifiers = modifiers
        this._observer()
        this

    ### @public ###
    registerAcceptor: (acceptor) ->
        this._acceptor = acceptor
        this._observer()
        this

    ### @public ###
    log: (msg) ->
        return if this.debug isnt 'true'
        console.log [this.tagName, {0:this}, msg]
        this

    ### @event ###
    onChange: (elements) ->
        this.log "triggered default event: onChange"

    properties:
        elements:
            type: String,
            value: 'solitare-card'
            notify: true
            reflectToAttribute: true
        debug:
            type: String
            value: 'false'
            notify: true
            reflectToAttribute: true
        modifiers:
            type: Object
            value: () -> {}
            notify: true
            reflectToAttribute: true