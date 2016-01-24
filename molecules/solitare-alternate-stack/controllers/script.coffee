Polymer
    is: 'solitare-alternate-stack'

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

    _setDrag: () ->
        stack = $(this.$$ '#stack')

        if this.show is 'true'
            if this.debug is 'true'
                this.log 'is now draggable'
            stack.draggable
                snap: true
                snapMode: 'inner'
                revert: true
        else
            if this.debug is 'true'
                this.log 'is now undraggable'
            if stack.data 'ui-draggable'
                stack.draggable "destroy"
        stack

    ready: () ->
        this._setDrag()

    set: (show, suit, value) ->
        card = this.$$ '#stack solitare-card'
        card.set suit, value
        if show is 'open'
            card.openCard()
        this._setDrag()

    log: (msg) ->
        console.log 'stack at card(' + this.suit + ',' + this.value + '): ' + msg