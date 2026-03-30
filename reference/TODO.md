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

- **Preset detection broken by ini values** — `presetMatches` was requiring all ini keys to equal defaults (since `pr.ini={}` empty). Fixed: skip non-preset check when preset section has no keys.
- **KeyLootNew snap** — `nearestLootSnap` changed `<` to `<=` so ties round up. `0.4` now snaps to `0.6` (Rare), matching the PZ game UI.
- **UndergroundDarkness enum** — removed from allowlist.json. Key is absent from Sandbox.json and all real preset files — fabricated annotation with no game-file backing.
- **Fabricated B42 keys purged** — CraftingYieldMultiplier, OreSpawnMultiplier, BlacksmithingEnabled, PotteryEnabled were agent-hallucinated; none appear in any real game file. Removed from allowlist.json, b42craft group, and all votes files.
- **Preset dropdown reverts to "custom" after reload** — `s.def` was raw unclamped value from Apocalypse.lua; clamped values loaded from file didn't match. Fixed: clamp `s.def` at schema build time in `buildSchema` (index.html).
- **Empty commits on unchanged save** — `commitPlayer` was PUT-ing files regardless of content. Fixed: `resolveFileUpdate` fetches existing GitHub file, compares base64 content; PUT skipped if unchanged. Averages files checked independently.
