# pz-vote TODO

Known gaps, validation items, and open questions. Ordered roughly by impact.

---

## Critical / Likely Broken

### 1. ~~WaterShut / ElecShut render as number inputs instead of dropdowns~~ FIXED
`WaterShut → Shutoff` and `FoodRotSpeed → FoodSpoil` added to `sandboxKeyMap`. `ElecShut`, `TimeSinceApo`, and `ErosionSpeed` have correct Sandbox.json keys already — no map needed.

### 2. ~~StartDay control type unconfirmed~~ RESOLVED
Confirmed in-game as a 1–31 dropdown. Sandbox.json has no `_option*` entries. Annotation added: `type: number, def: 9` — rendering as number input for usability (31-item dropdown is poor UX for a voting tool).

### 2b. ~~ZombieRespawn missing from zrespawn group~~ FIXED
`ZombieRespawn` (top-level dropdown: High/Normal/Low/None, Sandbox.json has options) was absent from the allowlist entirely. Added to `zrespawn` group. Distinct from `RespawnHours` which is a separate number field in the advanced section.

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

### 5. Rising preset PVP — design decision needed
**Finding:** All presets get `ini: {}` at build time — ini always falls back to schema defaults (PVP=1). Rising has no ini overrides anywhere. Whether Rising should force PVP=0 is a product call, not verifiable from the code or Rising.lua alone.
**If yes:** add `PRESETS.rising.ini = { PVP: 0 }` after preset construction in `loadGameFiles()`.

### 6. AnimalAgeModifier default index may be wrong
**Problem:** All livestock dropdowns confirmed in-game and `_unverified` flags cleared. One open question remains: `AnimalAgeModifier` def=4 — on the 6-slot scale [Ultra Fast…Very Slow], index 4 is "Slow", not "Normal". Apocalypse is supposed to be Normal aging. Possible the Apocalypse.lua value is stored differently or the scale is 0-based in some contexts.
**Action:** Check a live `servertest_SandboxVars.lua` from an Apocalypse server and confirm what value `AnimalAgeModifier` holds. If it's "Normal" the def is fine; if it's "Slow" the def should stay 4 and we accept it as correct.

### 7. UndergroundDarkness enum options are from memory, not verified
**Problem:** The options `["Pitch Black", "Dark", "Normal"]` in the annotations were inferred from the screenshot and prior knowledge — not from Sandbox.json. If the game uses different labels or a different order, the dropdown will show wrong text.
**Where to look:** `reference/game_files/Sandbox.json`, search for `UndergroundDarkness`. If `Sandbox_UndergroundDarkness_option1` exists, the annotation options should match it exactly (and the annotation `options` array can be removed — detectType will find them automatically).

### 8. ~~SixMonthsLater preset not in the UI dropdown~~ FIXED
Added `<option value="sixmonthslater">Six Months Later</option>` to all three player preset selects. Value is lowercase to match how `PRESETS` stores keys.

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

### 16. ~~Add console.warn for missing Sandbox.json key lookups~~ FIXED
`console.warn` added in `buildSchema()` after `detectType()`. Fires when type resolves to `number`, the key has no annotation, and `Sandbox_<key>_option1` doesn't exist — surfaces unexpected lookup failures in DevTools without spamming intentional numbers or annotated keys.

---

## Future Features

### 17. Vote tallying / real-time voting UI
**The original intent** of pz-vote is for players to vote on server settings. Currently the tool only builds a config file — there's no voting mechanism. Future work: player-facing vote form, tally display, server admin review/apply flow.

### 18. Config diff view
When loading a saved config or preset, show what changed from a baseline (e.g. "5 settings differ from Apocalypse"). Helpful for admins reviewing player vote results.

### 19. Direct server config push
If the server has an RCON or file API, the tool could push the generated SandboxVars.lua directly rather than requiring manual copy.
