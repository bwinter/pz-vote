# pz-vote TODO

Known gaps, validation items, and open questions. Ordered roughly by impact.

---

## Critical / Likely Broken

### 1. ~~WaterShut / ElecShut render as number inputs instead of dropdowns~~ FIXED
`WaterShut → Shutoff` and `FoodRotSpeed → FoodSpoil` added to `sandboxKeyMap`. `ElecShut`, `TimeSinceApo`, and `ErosionSpeed` have correct Sandbox.json keys already — no map needed.

### 2. StartDay control type unconfirmed
**Problem:** `Sandbox_StartDay_option1` does not exist — Sandbox.json has only a title entry. Currently renders as a number input. Need to confirm in-game whether it's actually a dropdown (specific day choices) or a free number (1–31).
**See:** `reference/ingame_checklist.md`

### 3. Browser testing not done
**Problem:** The full rewrite (dynamic loading, new control types, buildSchema/detectType) has never been opened in a browser. Unknown if it works at all.
**Steps:**
1. `cd /path/to/pz-vote && python3 -m http.server 8080`
2. Open `http://localhost:8080` in browser
3. Open DevTools console — check for fetch errors, JS exceptions
4. Verify each tab renders controls (not blank)
5. Verify enum dropdowns show correct options (not "1", "2", "3")
6. Verify loot rarity dropdowns show named labels ("Normal", "Rare", etc.)
7. Verify bool checkboxes render (not number inputs)
8. Load the Apocalypse preset and verify values look right
9. Generate output and verify SandboxVars.lua format is correct (nested tables)

---

## Correctness Issues

### 4. KeyLootNew default 0.4 snaps to wrong loot label
**Problem:** `KeyLootNew = 0.4` in Apocalypse.lua doesn't match any of the 6 named loot snap values (0.05, 0.2, 0.6, 1.0, 2.0, 3.0). `nearestLootSnap()` snaps it to 0.2 (Extreme Rare) on load. The user voted setting will save 0.2, not 0.4.
**Options:**
- Accept the snap (0.2 is close, and 0.4 isn't a named value)
- Add 0.4 as a 7th loot option with a custom label
- Store raw floats and only display the label (lossy display but lossless output)

### 5. Rising preset PVP ini value may be wrong
**Problem:** The Rising preset is a survivor-friendly scenario where PVP is likely off (PVP=0). The ini preset values are hardcoded in `index.html` for each preset — verify that Rising's ini section sets PVP=0. If the PRESETS object in index.html uses the same ini defaults for all presets, Rising will incorrectly show PVP=1.
**Where:** Search `index.html` for `Rising` and check how ini preset values are built in `buildPresetValues()`.

### 6. AnimalStatsModifier dropdown labels unverified
**Problem:** `AnimalRanchChance` is confirmed correct in Sandbox.json. `AnimalStatsModifier` has a Sandbox.json title/tooltip but no `_option*` strings. Currently uses a provisional enum with labels borrowed from `AnimalSpeed` scale ("Ultra Fast" → "Very Slow"), flagged `_unverified: true` in annotations. Labels are likely wrong for a stat-decay setting.
**Action:** Confirm real option labels in-game. See `reference/ingame_checklist.md`.
**Also:** `AnimalMetaStatsModifier` exists in Sandbox.json but is not in the allowlist — check if it should be added to `b42animals` group.

### 7. UndergroundDarkness enum options are from memory, not verified
**Problem:** The options `["Pitch Black", "Dark", "Normal"]` in the annotations were inferred from the screenshot and prior knowledge — not from Sandbox.json. If the game uses different labels or a different order, the dropdown will show wrong text.
**Where to look:** `reference/game_files/Sandbox.json`, search for `UndergroundDarkness`. If `Sandbox_UndergroundDarkness_option1` exists, the annotation options should match it exactly (and the annotation `options` array can be removed — detectType will find them automatically).

### 8. SixMonthsLater preset not in the UI dropdown
**Problem:** The preset file `reference/game_files/presets/SixMonthsLater.lua` is fetched and built into `PRESETS` at runtime, but `SixMonthsLater` may not be listed in the preset selector dropdown in the HTML header.
**Where:** Search `index.html` for the preset `<select>` element — verify `SixMonthsLater` is an `<option>`.

---

## Missing Settings (Present in game, absent from allowlist)

### 9. XP multipliers (per-skill) not included
**Problem:** The Character tab has a full grid of per-skill XP multipliers (Fitness, Strength, Axe, Blunt, etc.) under `MultiplierConfig` in the Lua output. Screenshots `7_character_2.png` and `7_character_3.png` show ~30 skill multipliers. These are all omitted from the `char` group.
**Decision needed:** Do we want to expose individual skill XP multipliers? They could be their own group. If yes, add all `MultiplierConfig.*` keys to a new `xpmult` group. These are all float number inputs.

### 10. Several zombie advanced settings omitted
**Problem:** Screenshot `2_zombie_3.png` shows "Advanced Zombie Settings" including: Population Multiplier peak/start, Rally group settings, Follow Sound Distance. Some are already in `zpop`/`zrespawn`, but others (RedistributeHours, FollowSoundDistance, RallyGroupSize, etc.) are excluded.
**Decision needed:** Show advanced zombie config? If yes, add a new `zadv` group with the ZombieConfig advanced keys.

### 11. Map settings (AllowMiniMap etc.) are under `misc`, but may warrant their own group
**Minor.** The in-game UI has map settings as part of the same screen. Currently these are in `misc`. Not a bug, just a grouping choice.

---

## UI / Output Issues

### 12. Output format for nested Lua tables needs verification
**Problem:** The tool writes `SandboxVars.lua` with nested tables (ZombieLore, ZombieConfig, Map, etc.). The exact nesting syntax and the list of which keys go into which nested table needs a full end-to-end test against a real PZ server load.
**Test method:** Generate a SandboxVars.lua from the tool, put it in a PZ server's `Saves/Multiplayer/ServerName/` directory, start the server, confirm it loads without error and sandbox settings match what was set.

### 13. `detectType` loot false-positive risk for future keys
**Problem:** `detectType()` uses `key.includes('Loot') && !key.includes('Respawn') && !key.includes('Hours')` to identify loot rarity keys. This works for current keys but could misfire if a future key contains "Loot" in a non-rarity context. Low risk now, worth noting for future maintenance.

### 14. Number inputs have no validation or bounds
**Problem:** `<input type="number">` fields accept any value. Some settings have natural bounds that the game enforces server-side but the UI doesn't communicate:
- `MaxPlayers`: should be > 0, reasonable max ~64 for most servers
- `HoursForCorpseRemoval`: 0 = never remove, negative is invalid
- `SafehouseDaySurvivedToClaim`: should be ≥ 0
- Loot float keys: if ever shown as raw numbers, valid range is 0.0–3.0+
**Options:** Add `min`/`max` to schema entries, or add client-side validation on output generation.

---

## Documentation / Reference Gaps

### 15. No mapping documented for which Lua keys go into which nested table
**Problem:** The tool infers Lua table nesting from `luaTableOf` built during `buildSchema()`. If that inference is wrong (e.g. a key appears in multiple preset tables), the output file will have keys in the wrong table or missing entirely.
**Recommendation:** Add a comment or table to `reference/schema.md` listing which keys go into ZombieLore, ZombieConfig, MultiplierConfig, Map, Basement vs. the root table.

### 16. Sandbox.json is a large file — no quick-reference for which keys exist
**Problem:** `reference/game_files/Sandbox.json` is the ground truth for labels and enum options, but it's large and hard to scan. If a key lookup silently fails (key not found), `detectType()` falls through to `number` without warning.
**Recommendation:** Add console.warn() in `buildSchema()` when a Sandbox.json key lookup fails, so missing/misnamed keys are visible in DevTools.

---

## Future Features

### 17. Vote tallying / real-time voting UI
**The original intent** of pz-vote is for players to vote on server settings. Currently the tool only builds a config file — there's no voting mechanism. Future work: player-facing vote form, tally display, server admin review/apply flow.

### 18. Config diff view
When loading a saved config or preset, show what changed from a baseline (e.g. "5 settings differ from Apocalypse"). Helpful for admins reviewing player vote results.

### 19. Direct server config push
If the server has an RCON or file API, the tool could push the generated SandboxVars.lua directly rather than requiring manual copy.
