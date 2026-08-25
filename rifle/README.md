# Rifle — modular Hammerspoon package

## Layout

```
rifle/
  init.lua          public API
  config.lua        user settings
  state.lua         runtime + JSON IPC
  modifiers.lua     posture / attachments multipliers
  registry.lua      weapon registration
  profiles.lua      save/load profiles
  core/
    hid.lua         TCP client → pointing daemon
    engine.lua      scale pattern + start/stop
    input.lua       event taps
  weapons/          one file per weapon
  patterns/         raw .dat curves
  profiles/         saved JSON profiles
```

## Add a weapon

1. Copy `weapons/_template.lua` → `weapons/mp5.lua`
2. Put curve steps in `patterns/mp5/default.dat` (`dx dy delay` per line)
3. Reload Hammerspoon — registry auto-loads `weapons/*.lua`

## Switch weapon (console)

```lua
local rifle = require("rifle")
rifle:setWeapon("ak47")
rifle:saveProfile("default")
```

## IPC (`~/.hammerspoon/macro_state.json`)

```json
{
  "enabled": true,
  "weapon": "ak47",
  "strength": 3,
  "profile": "default",
  "modifiers": {
    "posture": "stand",
    "ads": false,
    "moving": false,
    "scope": "none",
    "barrel": "none"
  }
}
```
