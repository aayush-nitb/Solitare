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

    ### @private ###
    _setDrag: () ->
        if this.draggable is 'true' and this.show is 'true'
            if this.debug is 'true'
                this.log 'is now draggable'
            $(this).draggable
                snap: this.dropzone
                snapMode: 'inner'
                revert: true
                revertDuration: 0
                start: (ev, ui) ->
                    this._nestedBeforeDrag = this.isNested()
                    return
                stop: (ev, ui) ->
                    if this.isNested() or this._nestedBeforeDrag
                        this._removeStyle "left"
                        this._removeStyle "top"
                    return
        else
            if this.debug is 'true'
                this.log 'is now undraggable'
            if $(this).data 'ui-draggable'
                $(this).draggable "destroy"
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

    ### @public ###
    isNested: () ->
        parent = $(this).parent()
        return 'false' if not parent
        return parent[0].tagName is this.tagName

    ### @public ###
    openCard: () ->
        this.show = 'true'
        if this.suit is undefined and this.value is undefined
            this.shuffle()
        $(this).css this.openedCard
        this._setDrag()

    ### @public ###
    closeCard: () ->
        this.show = 'false'
        $(this).css this.closedCard
        this._setDrag()

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

    ### @public ###
    setDraggable: (value) ->
        this.draggable = value
        this._setDrag()

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
        console.log 'card(' + this.suit + ',' + this.value + '): ' + msg

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