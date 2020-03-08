# clipboard

A simple to use clipboard library, which supports:
- Setting text as the clipboard content
- Getting the clipboard content
- Clearing the clipboard

It binds to the libclipboard library:
https://github.com/jtanx/libclipboard

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     clipboard:
       github: data-niklas/clipboard
   ```

2. Run `shards install`

## Usage

```crystal
require "clipboard"

success = Clipboard.set_text("Some text")
current_clipboard_text = Clipboard.get_text()
# Now clearing it
Clipboard.clear()

```

When setting the clipboard content:
- The program may not exit directly!
- Wait at least ~100 milliseconds before exiting
- Else `get_text()` will return the correct text, but Ctrl+V won't work

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/data-niklas/clipboard/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Niklas Loeser](https://github.com/data-niklas) - creator and maintainer
