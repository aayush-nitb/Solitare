Polymer
    is: 'solitare-card'

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

    _xy: () ->
        x = -73 * (this.value - 1) + 'px'
        y = switch
            when this.suit is 'clubs' then " 0px"
            when this.suit is 'spades' then " -98px"
            when this.suit is 'hearts' then " -196px"
            when this.suit is 'diamonds' then " -294px"
        x+y

    _setDrag: () ->
        card = $(this.$$ '#card')
        if this.draggable is 'true' and this.show is 'true'
            if this.debug is 'true'
                this.log 'is now draggable'
            card.draggable
            snap: true
            snapMode: 'inner'
            revert: true
        else
            if this.debug is 'true'
                this.log 'is now undraggable'
            if card.is 'ui-draggable'
                card.draggable "destroy"
        card

    ready: () ->
        this.openedCard =
            'background-image': images 'cards.png'
            'background-position': this._xy()
            'background-size': '950px 392px'
        this.closedCard =
            'background-image': images 'card-back-blue.png'
            'background-position': '0px 0px'
            'background-size': '100% 100%'

        switch this.show
            when 'true' then $(this.$$ '#card').css this.openedCard
            when 'false' then $(this.$$ '#card').css this.closedCard

        this._setDrag()

    openCard: () ->
        this.show = 'true'
        $(this.$$ '#card').css this.openedCard
        this._setDrag()

    closeCard: () ->
        this.show = 'false'
        $(this.$$ '#card').css this.closedCard
        this._setDrag()

    set: (suit, value) ->
        this.suit = suit
        this.value = value
        this.openedCard['background-position'] = this._xy()
        this._setDrag()

    setDraggable: (value) ->
        this.draggable = value
        this._setDrag()

    log: (msg) ->
        console.log 'card(' + this.suit + ',' + this.value + '): ' + msg