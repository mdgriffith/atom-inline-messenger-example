{ Point
, View
, Range
} = require 'atom'

path = require 'path'

module.exports =

    activate: (state) ->
      atom.commands.add 'atom-text-editor',
        'atom-inline-messenger-example:insert': (event) =>
          @run()

      @messenger = null
      @messages = []

    deactivate: ->
      @messages.map (msg) -> msg.destroy()

    serialize: ->
      return "{}"

    consumeInlineMessenger: (messenger) ->
      @messenger = messenger

    run: ->
      if @messenger
        atom.workspace.open('messagingExample.py').then (editor) =>
          editor.insertText(@exampleCode())

          @messages.push @messenger.message
            range: [[15,0],[15,11]]
            text: "Inconsistent indentation"
            severity: "warning"

          @messages.push @messenger.message
            range: [[12,22],[12,29]]
            text: "Should be..uhh...False?"
            severity: "warning"

          @messages.push @messenger.message
            range: [[22,0],[26,1]]
            text: "I wrote this so I could make a comment on multiline code."
            severity: "error"

          @messages.push @messenger.message
            range: [[4,0],[4,21]]
            text: "New style python classes inherit from object"
            suggestion: 'class ExampleCode(object):'


          traceStep1 = {
            filePath: '/Users/matthewgriffith/atom-inline-messaging/package.json'
            range: new Range([30,0],[30,80])
            text: 'tracing example message'
          }

          @messages.push @messenger.message
            range: [[30,0],[30,28]]
            text: "This message is an example of a message with a trace"
            severity: "error"
            trace: [ traceStep1 ]


    exampleCode: -> """# This files was made as some example code to show an example
# of code with messages from atom-inline-messenger


class ExampleCode():
    \"\"\"
    Some example code to apply messages
    to for atom-inline-messenger-example
    \"\"\"

    def __init__(self):
        self.value1 = True
        self.value2 = True

    def method1(self):
      pass

    def method2(self):
        print "Here's method 2!"



javascriptFn = function(){
    thisFn = "is obviously javascript and should not be in a python module";
    seriously = "what are you doing?"
    return undefined
}



class ExampleCode2(object):

  def __init__(self):
    print "Hey, this is an example"



if __name__ == "__main__":
    example = ExampleCode()
    example.method2()











"""
