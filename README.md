## Getting Started

This package has example usage of the [inline messenger](https://github.com/mdgriffith/atom-inline-messenger) package.


Inline messenger provides a service you can use in other Atom projects.  To use
it, include `inline-messenger` in the `consumedServices` section of your `package.json`:

```json
{
  "name": "my-package",
  "consumedServices": {
    "inline-messenger": {
      "versions": {
        "^1.0.0": "consumeInlineMessenger"
      }
    }
  }
}
```

Then call methods on the service in your package's main module.

The `message` creates a message in the active editor.

```coffee
module.exports =
  activate: ->
    @messages = []

  consumeInlineMessenger: (messenger) ->
    @messenger = messenger

    @messages.push @messenger.message
              range: [[22,0], [25,8]]
              text: "A New Message"
              severity: "warning"

    @messages.push @messenger.message
              range: [[35,0], [35,8]]
              text: "A New Code Suggestion"
              suggestion: "myNewCodeSuggestion();"

  deactivate: ->
    @messages.map (msg) -> msg.destroy()
    @messages = []
```

## The Message Command

The message method takes the following parameters
  * `range` - The range to highlight in the editor
  * `text` - The text to display in the message
  * `severity` - Can be any of the following: info, warning, error, suggestion.  This will affect the coloring of the message.
  * `suggestion` - Provide a code suggestion to replace the highlighted text.


## Commands
  * `next-message` -> Jumps to the next message.  The default keyboard shortcut is alt-down
  * `prev-message` -> Jumps to the previous message.  The default keyboard shortcut is alt-up
  * `accept-suggestion` -> If the current message is a code suggestion, this command will make the suggested changes for you.  The default is cmd-shift-a


## Settings
  * `Message Positioning` - For messages that span multiple lines, show them either below the highlighted code or to the right.  Defaults to below.
  * `Show Keyboard Shortcut For Suggestions` - Show keyboard shortcut reminder at the bottom of a suggestion.  Defaults to true.
  * `Accept Suggestion Animation` - Show a small highlight flash when suggested code is accepted.  Defaults to true.
