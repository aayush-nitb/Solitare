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
        debug:
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
                snap: '.waiting-for-card'
                snapMode: 'inner'
                revert: true
        else
            if this.debug is 'true'
                this.log 'is now undraggable'
            if stack.data 'ui-draggable'
                stack.draggable "destroy"
        stack.find('#nested-stack')

    ready: () ->
        $(this.$$ '#nested-stack').droppable drop: (e, ui) ->
            return false if $(this).find('solitare-card').length
            oldCard = ui.draggable.parent()
            suit = oldCard.attr 'suit'
            value = oldCard.attr 'value'
            topmostCard = $(this).siblings 'solitare-card'
            return false if '1' is topmostCard.attr 'value'
            return false if oldCard[0].color() is topmostCard[0].color()
            return false if (parseInt value) + 1 isnt parseInt topmostCard.attr 'value'
            oldCard.detach().appendTo this
        this._setDrag()

    set: (show, suit, value) ->
        card = this.$$ '#stack solitare-card'
        card.set suit, value
        if show is 'open'
            card.openCard()
        this._setDrag()

    appendTo: (holder) ->
        $(holder).append this
        $(holder).removeClass 'waiting-for-card'
        this

    color: () ->
        switch this.suit
            when 'clubs' then "black"
            when 'spades' then "black"
            when 'hearts' then "red"
            when 'diamonds' then "red"

    log: (msg) ->
        console.log 'stack at card(' + this.suit + ',' + this.value + '): ' + msg