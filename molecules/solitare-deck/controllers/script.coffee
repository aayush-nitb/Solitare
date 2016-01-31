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
        $(this).find(this.elements).each () ->
            for modifier, value of deck.modifiers
                this[modifier] = value
        return

    ### @public ###
    setModifiers: (modifiers) ->
        this.modifiers = modifiers
        this._observer()
        this

    ### @public ###
    log: (msg) ->
        return if this.debug isnt 'true'
        console.log [this.tagName, {0:this}, msg]
        this

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