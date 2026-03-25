# pz-vote TODO

Known gaps, validation items, and open questions. Ordered roughly by impact.

---

## Critical / Likely Broken

### 1. Browser testing not done
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

### 2. KeyLootNew default 0.4 snaps to wrong loot label
**Problem:** `KeyLootNew = 0.4` in Apocalypse.lua doesn't match any of the 6 named loot snap values (0.05, 0.2, 0.6, 1.0, 2.0, 3.0). `nearestLootSnap()` snaps it to 0.2 (Extreme Rare) on load. The user voted setting will save 0.2, not 0.4.
**Options:**
- Accept the snap (0.2 is close, and 0.4 isn't a named value)
- Add 0.4 as a 7th loot option with a custom label
- Store raw floats and only display the label (lossy display but lossless output)

### 3. AnimalAgeModifier default index may be wrong
**Problem:** `AnimalAgeModifier` def=4 — on the 6-slot scale [Ultra Fast…Very Slow], index 4 is "Slow", not "Normal".
**Action:** Check a live `servertest_SandboxVars.lua` from an Apocalypse server and confirm what value `AnimalAgeModifier` holds. If it's "Normal" the def is fine; if it's "Slow" the def should stay 4 and we accept it as correct.

### 4. UndergroundDarkness enum options unverified
**Problem:** The options `["Pitch Black", "Dark", "Normal"]` were inferred from prior knowledge — not from Sandbox.json. If the game uses different labels or order, the dropdown will show wrong text.
**Fix:** Search `reference/game_files/Sandbox.json` for `UndergroundDarkness`. If `Sandbox_UndergroundDarkness_option1` exists, remove the annotation `options` array — detectType will find them automatically.

---

## Missing Settings (Present in game, absent from allowlist)

### 5. XP multipliers (per-skill) not included
**Problem:** ~30 per-skill XP multipliers (`MultiplierConfig.*`) are omitted from the `char` group. Screenshots `7_character_2.png` and `7_character_3.png` show the full grid.
**Decision needed:** Add a new `xpmult` group? All are float number inputs.

### 6. Several zombie advanced settings omitted
**Problem:** `2_zombie_3.png` shows advanced settings including RedistributeHours, FollowSoundDistance, RallyGroupSize, etc. Some are in `zpop`/`zrespawn` but others are missing.
**Decision needed:** Add a new `zadv` group with ZombieConfig advanced keys?

### 7. Map settings grouping
**Minor.** Map settings (AllowMiniMap etc.) are in `misc` but the in-game UI has them as a distinct section. Not a bug, just a grouping choice.

---

## UI / Output Issues

### 8. Output format for nested Lua tables needs verification
**Problem:** The tool writes `SandboxVars.lua` with nested tables (ZombieLore, ZombieConfig, Map, etc.). The exact nesting and key-to-table assignment needs a full end-to-end test against a real PZ server load.
**Test method:** Generate a SandboxVars.lua, put it in `Saves/Multiplayer/ServerName/`, start the server, confirm it loads without error.

### 9. `detectType` loot false-positive risk
**Problem:** `detectType()` identifies loot keys via `key.includes('Loot') && !key.includes('Respawn') && !key.includes('Hours')`. Works now but could misfire on future keys. Low risk, noted for maintenance.

### 10. Number inputs have no validation or bounds
**Problem:** `<input type="number">` accepts any value. Natural bounds exist but aren't communicated:
- `MaxPlayers`: should be > 0
- `HoursForCorpseRemoval`: 0 = never, negative invalid
- `SafehouseDaySurvivedToClaim`: should be ≥ 0
**Options:** Add `min`/`max` to schema entries, or validate on output generation.

---

## Documentation / Reference Gaps

### 11. No mapping documented for Lua table nesting
**Problem:** The tool infers which keys go into ZombieLore, ZombieConfig, MultiplierConfig, Map, Basement vs. root from `luaTableOf` in `buildSchema()`. If inference is wrong, keys end up in the wrong table.
**Recommendation:** Add a table to `reference/schema.md` documenting the key-to-table mapping.

---

## Future Features

### 12. Vote tallying / real-time voting UI
The tool currently only builds a config file. Future work: player-facing vote form, tally display, server admin review/apply flow.

### 13. Config diff view
When loading a saved config or preset, show what changed from a baseline. Helpful for admins reviewing vote results.

### 14. Direct server config push
If the server has RCON or a file API, push the generated SandboxVars.lua directly rather than requiring manual copy.

---

## Done

- **WaterShut / ElecShut dropdowns** — `sandboxKeyMap` entries added; ElecShut/TimeSinceApo/ErosionSpeed had correct keys already.
- **StartDay control type** — confirmed number input (31-item dropdown is poor UX); annotation added.
- **ZombieRespawn missing from allowlist** — added to `zrespawn` group (distinct from `RespawnHours` number field).
- **SixMonthsLater preset missing from UI** — `<option value="sixmonthslater">` added to all three player preset selects.
- **console.warn for missing Sandbox.json lookups** — added in `buildSchema()` after `detectType()`.
- **Rising preset PVP ini value** — not a bug; presets don't seed ini fields by design.
- **UI column alignment ((i) icon pushes columns)** — fixed with consistent `.s-info-slot` placeholder on every row.
- **Horizontal scrollbar / content wider than viewport** — fixed by removing `min-width:900px` from `#col-header` and `#tree`.
- **All livestock dropdowns** — confirmed in-game, `_unverified` flags cleared, full 13-key `b42animals` group.
- **All World/Nature/Meta/Character/Vehicle dropdowns** — confirmed in-game with screenshots, annotations added.
