{ Point
, View
} = require 'atom'

path = require 'path'

module.exports =
   
    activate: (state) ->
      atom.commands.add 'atom-text-editor',
        'atom-inline-messenger:insert': (event) =>
          @run()

      # atom.commands.add 'atom-text-editor',
      #   'atom-inline-messenger:clear': (event) =>
      #     @clear()

      @messenger = null
      

    deactivate: ->

    serialize: ->
      return "{}"

    consumeInlineMessenger: (messenger) ->
      @messenger = messenger

    run: ->
      # editor = atom.workspace.getActiveEditor()

      if @messenger
       

        @messenger.message
          start: [22,0]  
          end: [22,8] 
          text: "A New Message!"
          severity: "warning"
          debug: true


        @messenger.message
          start: [9,0]  
          end: [14,10] 
          text: "CONTENT!"
          severity: "warning"
          debug: true

        @messenger.suggest
          start: [18,0] 
          end: [25,80]
          text: 'Why not'
          suggestedCode: "atom.commands.add 'atom-text-editor',"
          debug: true

        @messenger.message
          start: [18,0] 
          end: [18,9]   
          text: "Short Inline Message!"
          severity: "warning"
          debug: true


        @messenger.message
          start: [19,4] 
          end: [19,80]   
          text: "Short Inline Message!"
          severity: "warning"
          debug: true

      
        @messenger.message
          start: [32,0] 
          end: [32,9]   
          text: "Short Inline Message!"
          severity: "warning"
          debug: true



    

