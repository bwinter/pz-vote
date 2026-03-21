# PZ Server Vote

A local voting tool for Project Zomboid server settings.
Three players each drag sliders to their preferred values.
The tool saves per-player files and an averaged result file.

## Requirements

**Chrome or Edge 86+** — uses the File System Access API.
Firefox does not support `showDirectoryPicker()`.

## Quick Start

1. Create a folder anywhere (e.g. `C:\pz_vote\`)
2. Put `vote.html` in that folder
3. Open `vote.html` in Chrome or Edge
4. Click **Open Folder** and pick the same folder
5. Adjust sliders for each player
6. Click **Save**

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

## Naming convention

Files are prefixed with their player index so they always load in
consistent order regardless of filename changes:

    0_Diesel.ini        → Player 1 slot
    1_GunFox.ini        → Player 2 slot
    2_SnowCrash.ini     → Player 3 slot

## Covered settings

**server.ini:** PVP, safety system, sleep, safehouses, max players,
loot respawn.

**SandboxVars.lua:** World timeline, zombie population, zombie
character (all 16 lore settings), zombie respawn, loot by category
(10 sliders), loot cleanup, character & survival, environment,
farming & nature, meta events, vehicles (13 settings), corpses &
blood, misc & display.

~90 settings total.
