# PZ Server Vote

A voting tool for Project Zomboid server settings (Build 42).
Three players each set their preferred values; the tool averages them and
saves config files directly to GitHub.

Live: **https://bwinter.github.io/pz-vote/**

## How it works

1. Open the URL in any browser
2. Configs auto-load from GitHub on page open
3. Click **⚙️ Settings**, paste the shared GitHub token into the token field
4. Adjust controls, click **☁️ Save** — your vote commits directly to the repo
5. Other players click **🔄 Reload** to see the latest

The **avg** column updates automatically whenever any player saves.

## Output files

Saved under `votes/` in this repo:

```
votes/0_Diesel.ini             votes/0_Diesel_SandboxVars.lua
votes/1_GunFox.ini             votes/1_GunFox_SandboxVars.lua
votes/2_SnowCrash.ini          votes/2_SnowCrash_SandboxVars.lua
votes/averages.ini             votes/averages_SandboxVars.lua
```

Copy `averages_SandboxVars.lua` → `servertest_SandboxVars.lua` and
`averages.ini` → `servertest.ini` into the server's `Zomboid/Server/` directory.

## Controls

Matches the PZ in-game sandbox UI:

| Type | Control |
|------|---------|
| Boolean | Checkbox |
| Enum (fixed options) | `<select>` dropdown |
| Loot rarity | `<select>` — Insane / Extremely Rare / Rare / Normal / Common / Abundant |
| Number | `<input type="number">` |

## Covered settings

**server.ini:** PVP, safety system, sleep, safehouses, max players, loot respawn.

**SandboxVars.lua:** World timeline, zombie population, zombie lore (16 settings),
zombie respawn, loot by category (21 float multipliers), loot cleanup,
character & survival, environment, farming & nature, meta events,
vehicles (13 settings), corpses & blood, misc & display, B42 animals, B42 basements.

~90 settings total. Schema loads dynamically from game files at startup — no
hardcoded values in `index.html`.

## Reference materials

`reference/` contains B42 game data used at runtime (`game_files/Sandbox.json`, preset `.lua` files, screenshots) and maintenance files (`allowlist.json`, `schema.md`, `TODO.md`). `allowlist.json` is the only hand-authored config — it controls which keys appear in the UI.
