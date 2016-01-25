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
        x = -100 * (this.value - 1) + '%'
        y = switch
            when this.suit is 'clubs' then " 0"
            when this.suit is 'spades' then " -100%"
            when this.suit is 'hearts' then " -200%"
            when this.suit is 'diamonds' then " -300%"
        x+y

    _setDrag: () ->
        card = $(this)

        if this.draggable is 'true' and this.show is 'true'
            if this.debug is 'true'
                this.log 'is now draggable'
            card.draggable
                snap: '.waiting-for-card'
                snapMode: 'inner'
                revert: true
        else
            if this.debug is 'true'
                this.log 'is now undraggable'
            if card.data 'ui-draggable'
                card.draggable "destroy"
        card

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

        this._setDrag()

    openCard: () ->
        this.show = 'true'
        $(this).css this.openedCard
        this._setDrag()

    closeCard: () ->
        this.show = 'false'
        $(this).css this.closedCard
        this._setDrag()

    set: (suit, value) ->
        this.suit = suit
        this.value = value
        this.openedCard['background-position'] = this._xy()
        this._setDrag()

    setDraggable: (value) ->
        this.draggable = value
        this._setDrag()

    color: () ->
        switch this.suit
            when 'clubs' then "black"
            when 'spades' then "black"
            when 'hearts' then "red"
            when 'diamonds' then "red"

    log: (msg) ->
        console.log 'card(' + this.suit + ',' + this.value + '): ' + msg