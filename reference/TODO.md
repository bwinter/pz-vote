# pz-vote TODO

Known gaps, validation items, and open questions. Ordered roughly by impact.

---

## Correctness Issues

---

## UI / Output Issues

### 1. `detectType` loot false-positive risk
**Problem:** `detectType()` identifies loot keys via `key.includes('Loot') && !key.includes('Respawn') && !key.includes('Hours')`. Works now but could misfire on future keys. Low risk, noted for maintenance.

### 2. Number inputs have no validation or bounds
**Problem:** `<input type="number">` accepts any value. Natural bounds exist but aren't communicated:
- `MaxPlayers`: should be > 0
- `HoursForCorpseRemoval`: 0 = never, negative invalid
- `SafehouseDaySurvivedToClaim`: should be ≥ 0
**Options:** Add `min`/`max` to schema entries, or validate on output generation.

---

## Documentation / Reference Gaps

---

## Future Features

### 3. Vote tallying / real-time voting UI
The tool currently only builds a config file. Future work: player-facing vote form, tally display, server admin review/apply flow.

### 4. Config diff view
When loading a saved config or preset, show what changed from a baseline. Helpful for admins reviewing vote results.

### 5. Direct server config push
If the server has RCON or a file API, push the generated SandboxVars.lua directly rather than requiring manual copy.

---

## Done

- **Browser testing** — passed. Dynamic loading, controls, and presets all render correctly.
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
- **AnimalAgeModifier default** — confirmed Normal (index 4, 1-based scale). Live `Apocalypse_SandboxVars.lua` in `reference/game_files/server_output/` verified.
- **Preset detection broken by ini values** — `presetMatches` was requiring all ini keys to equal defaults (since `pr.ini={}` empty). Fixed: skip non-preset check when preset section has no keys.
- **Tooltip `\n` rendering literally** — Sandbox.json uses escaped `\n`. Fixed with `.replace(/\\n/g,'\n')` + `white-space:pre-line`.
- **KeyLootNew snap** — `nearestLootSnap` changed `<` to `<=` so ties round up. `0.4` now snaps to `0.6` (Rare), matching the PZ game UI.
- **UndergroundDarkness enum** — removed entirely from allowlist.json. Key is absent from Sandbox.json and from all real game preset files — it was a fabricated annotation with no game-file backing.
- **Fabricated B42 keys purged** — CraftingYieldMultiplier, OreSpawnMultiplier, BlacksmithingEnabled, PotteryEnabled were agent-hallucinated; none appear in any real game file. Removed from allowlist.json, the b42craft group, and all votes files.
- **Lua table nesting** — documented in `reference/schema.md` § Lua Table Nesting.
- **Preset dropdown reverts to "custom" after reload** — `s.def` was raw unclamped value from Apocalypse.lua; clamped values loaded from file didn't match. Fixed: clamp `s.def` at schema build time in `buildSchema` (index.html).
- **Empty commits on unchanged save** — `commitPlayer` was PUT-ing files regardless of content. Fixed: `resolveFileUpdate` fetches existing GitHub file, compares base64 content; PUT skipped if unchanged. Averages files checked independently.
