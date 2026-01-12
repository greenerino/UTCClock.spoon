# UTCClock.spoon

A simple UTC time menu bar item and Unix timestamp converter

## Installation & Usage
```bash
cd ~/.hammerspoon/Spoons/
git clone git@github.com:greenerino/UTCClock.spoon.git
```

Then, in `init.lua`:
```lua
UTCClock = hs.loadSpoon('UTCClock')
UTCClock:start()
```

Both the UTC clock and epoch menu items are enabled by default. You can disable them like so, before calling `UTCClock:start()`:
```lua
UTCClock.enableEpoch = false
UTCClock.enableClock = false
```

Finally, you can click on the UTC clock menu item to translate a timestamp, and you can click on the epoch menu item to copy the current timestamp to your clipboard.
