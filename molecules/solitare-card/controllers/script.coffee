Polymer
    is: 'solitare-card'

    ### @override ###
    attributeChanged: (name, type) ->
        if name is 'suit' or name is 'value'
            this.set this.suit, this.value
        if name is 'dx' or name is 'dy'
            this.align this.dx, this.dy
        if name is 'draggable'
            this.setDraggable this.draggable
        if name is 'show' and this.show is 'true'
            this.openCard()
        if name is 'show' and this.show is 'false'
            this.closeCard()
        return

    ### @private ###
    _xy: () ->
        x = -100 * (this.value - 1) + '%'
        y = switch
            when this.suit is 'clubs' then " 0"
            when this.suit is 'spades' then " -100%"
            when this.suit is 'hearts' then " -200%"
            when this.suit is 'diamonds' then " -300%"
        x+y

    ### @private ###
    _removeStyle: (attr, apply) ->
        newStyles = []
        oldStyles = apply or $(this).attr("style").split(';')
        for style in oldStyles
            style = style.trim()
            continue if style is ''
            continue if style.match('^' + attr + ':')
            newStyles.push style
        $(this).attr "style", newStyles.join(';')
        this

    ### @private ###
    _setDrag: () ->
        if this.draggable is 'true' and this.show is 'true'
            $(this).draggable
                snap: this.dropzone
                snapMode: 'inner'
                revert: true
                revertDuration: 0
                start: (ev, ui) ->
                    this._nestedBeforeDrag = this.isNested()
                    this.onDragStart ev, ui
                    return
                stop: (ev, ui) ->
                    if this.isNested() or this._nestedBeforeDrag
                        this._removeStyle "left"
                        this._removeStyle "top"
                    this.onDragStop ev, ui
                    return
                drag: (ev, ui) ->
                    this.onDrag ev, ui
                    return
            this.log 'is now draggable'
        else
            $(this).draggable "destroy" if $(this).data 'ui-draggable'
            this.log 'is now undraggable'
        this

    ### @override ###
    ready: () ->
        this.openedCard =
            'background-image': images 'cards.png'
            'background-position': this._xy()
            'background-size': '1300% 400%'
        this.closedCard =
            'background-image': images 'card-back-blue.png'
            'background-position': '0 0'
            'background-size': '100% 100%'

        switch this.show
            when 'true' then $(this).css this.openedCard
            when 'false' then $(this).css this.closedCard

        if this.suit is undefined and this.value is undefined and this.show is 'true'
            this.shuffle()

        this.align this.dx, this.dy
        this._setDrag()
        return

    ### @override ###
    attached: () ->
        this.onReady()
        return

    ### @public ###
    isNested: () ->
        parents = $(this).parents(this.tagName)
        return false if not parents
        return false if not parents.length
        true

    ### @public ###
    openCard: () ->
        this.show = 'true'
        if this.suit is undefined and this.value is undefined
            this.shuffle()
        $(this).css this.openedCard
        this._setDrag()
        this

    ### @public ###
    closeCard: () ->
        this.show = 'false'
        $(this).css this.closedCard
        this._setDrag()
        this

    ### @public ###
    set: (suit, value) ->
        this.suit = suit
        this.value = value
        this.openedCard['background-position'] = this._xy()
        if this.show is 'true' then this.openCard() else this.closeCard()
        this

    ### @public ###
    shuffle: () ->
        suits = ['clubs', 'spades', 'hearts', 'diamonds']
        suit = Math.floor 4 * Math.random()
        value = 1 + Math.floor 13 * Math.random()
        this.set suits[suit], value
        this

    ### @public ###
    setDraggable: (value) ->
        this.draggable = value
        this._setDrag()
        this

    ### @public ###
    align: (dx, dy) ->
        this.dx = dx
        this.dy = dy
        this.customStyle['--dx'] = '' + this.dx + '%';
        this.customStyle['--dy'] = '' + this.dy + '%';
        this.updateStyles();
        this

    ### @public ###
    color: () ->
        switch this.suit
            when 'clubs' then "black"
            when 'spades' then "black"
            when 'hearts' then "red"
            when 'diamonds' then "red"

    ### @public ###
    log: (msg) ->
        return if this.debug isnt 'true'
        console.log ["card", {0:this}, msg]
        this

    ### @event ###
    onReady: () ->
        this.log "fired default event: onReady"

    ### @event ###
    onDragStart: (ev, ui) ->
        this.log "fired default event: onDragStart"

    ### @event ###
    onDrag: (ev, ui) ->
        this.log "fired default event: onDrag"

    ### @event ###
    onDragStop: (ev, ui) ->
        this.log "fired default event: onDragStop"

    properties:
        value:
            type: Number
            notify: true
            reflectToAttribute: true
        suit:
            type: String
            notify: true
            reflectToAttribute: true
        show:
            type: String
            value: 'false'
            notify: true
            reflectToAttribute: true
        draggable:
            type: String
            value: 'true'
            notify: true
            reflectToAttribute: true
        debug:
            type: String
            value: 'false'
            notify: true
            reflectToAttribute: true
        dx:
            type: Number
            value: 0
            notify: true
            reflectToAttribute: true
        dy:
            type: Number
            value: 20
            notify: true
            reflectToAttribute: true
        dropzone:
            type: String
            value: 'solitare-card-dropzone'
            notify: true
            reflectToAttribute: true