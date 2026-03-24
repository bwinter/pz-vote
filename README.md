# PZ Server Vote

A voting tool for Project Zomboid server settings (Build 42).
Three players each drag sliders to their preferred values.
The tool saves per-player files and an averaged result file to GitHub.

Live: **https://bwinter.github.io/pz-vote/**

## Requirements

**Chrome or Edge 86+** — uses the File System Access API.
Firefox does not support `showDirectoryPicker()`.

## Files produced on save

```
0_Diesel.ini
0_Diesel_SandboxVars.lua
1_GunFox.ini
1_GunFox_SandboxVars.lua
2_SnowCrash.ini
2_SnowCrash_SandboxVars.lua
averages.ini
averages_SandboxVars.lua
```

The `averages_SandboxVars.lua` file is ready to copy into your PZ
server's `Zomboid/Server/` directory as your `servertest_SandboxVars.lua`.

## Loading existing settings

On **Open Folder**, the tool scans for `N_NAME.ini` and
`N_NAME_SandboxVars.lua` files (N = 0, 1, 2) and loads them
automatically. Player name input boxes update from the filenames.

## Covered settings

**server.ini:** PVP, safety system, sleep, safehouses, max players,
loot respawn.

**SandboxVars.lua:** World timeline, zombie population, zombie
character (all 16 lore settings), zombie respawn, loot by category
(21 float multipliers), loot cleanup, character & survival, environment,
farming & nature, meta events, vehicles (13 settings), corpses &
blood, misc & display, B42 animals, B42 basements.

~90 settings total.

## Reference materials

`reference/` contains authoritative B42 game data used to build and maintain `index.html`.

### `reference/game_files/`

| File/folder | Purpose |
|---|---|
| `Sandbox.json` | **Key authority.** Game translation file — every SandboxVars key name, display name, option count, and tooltip. Format: `Sandbox_KEYNAME` → actual Lua key is `KEYNAME`. |
| `presets/` | Real B42 preset Lua files direct from the game. Ground truth for all key names, nested table structure, defaults, and valid values. |
| `presets/Apocalypse.lua` | Standard difficulty reference — most schema defaults are based on this. |
| `presets/Extinction.lua` | High-zombie, harsh-loot extreme preset. |
| `presets/Outbreak.lua` | Balanced survival preset. |
| `presets/Rising.lua` | Low zombie count, rich loot — builder-friendly. |
| `presets/SixMonthsLater.lua` | Post-apocalypse late-game preset. |
| `server_ini/` | Matching `.cfg` server.ini preset files — reference for server.ini key names and their valid values. |

### `reference/schema.md`

Complete key reference for B42 SandboxVars — all key names, types, defaults, nested table groups, loot float scale, and preset comparison table. Authoritative source for maintaining `index.html`.

### Key things to know when editing `index.html`

- **Loot keys are floats** (0.0–3.0), not enum indices. Named snaps: 0.05=Insane, 0.2=Extremely Rare, 0.6=Rare, 1.0=Normal, 2.0=Common, 3.0=Abundant.
- **Nested Lua tables:** ZombieLore, ZombieConfig, MultiplierConfig, Map, and Basement keys are nested in the output. Schema entries carry a `luaTable` property.
- **Key conflicts:** `Strength` and `Farming` exist in both ZombieLore and MultiplierConfig. The parser uses `Table.Key` composite keys to disambiguate.
- **Backward compat:** Old flat-format saves (`SandboxVars = { Speed=4 }`) still load — `SandboxVars` is treated as a null table context during parsing.
