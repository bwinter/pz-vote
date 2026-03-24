# In-game verification checklist

All items verified from in-game screenshots, March 2026 (B42 unstable).

---

## Zombie tab

- [x] **Population Multiplier** (`PopulationMultiplier`)
  `Insane / Very High / High / Normal / Low / None / Custom`
  *(7 options — "Insane" and "Custom" were not in the provisional list)*

- [x] **Population Start Multiplier** (`PopulationStartMultiplier`)
  Same 7-slot scale: `Insane / Very High / High / Normal / Low / None / Custom`

- [x] **Population Peak Multiplier** (`PopulationPeakMultiplier`)
  Same 7-slot scale: `Insane / Very High / High / Normal / Low / None / Custom`

- [x] **Zombie Respawn** — TWO SEPARATE CONTROLS (not one):
  - `Zombie Respawn` — top-level dropdown: `High / Normal / Low / None` (4 options)
  - `Respawn Hours` — separate number field (shown as 0.0 in advanced section)
  These are distinct keys. Do not conflate them.

---

## World tab

- [x] **House Alarms Frequency** (`Alarm`)
  `Never / Extremely Rare / Rare / Sometimes / Often / Very Often`
  *(6 options — no "Always" at the top end)*

- [x] **Locked Houses Frequency** (`LockedHouses`)
  Same 6-slot scale: `Never / Extremely Rare / Rare / Sometimes / Often / Very Often`

- [x] **Refrigeration Effectiveness** (`FridgeFactor`)
  `Very Low / Low / Normal / High / Very High / No decay`
  *(6 options — "No decay" is the top option, not "Very High")*

- [x] **Initial Minimum Gas Pump Amount** (`FuelStationGasMin`)
  `Empty / Super Low / Very Low / Low / Normal / High / Very High / Full / Custom`
  *(9 options — "Super Low", "Full", and "Custom" not previously known)*

- [x] **Initial Maximum Gas Pump Amount** (`FuelStationGasMax`)
  Same 9-slot scale: `Empty / Super Low / Very Low / Low / Normal / High / Very High / Full / Custom`

---

## Nature tab (on World tab panel)

- [x] **Temperature** (`Temperature`)
  `Very Cold / Cold / Normal / Hot / Very Hot` (5 options)

- [x] **Rain** (`Rain`)
  `Very Dry / Dry / Normal / Rainy / Very Rainy` (5 options)

- [x] **Fishing Abundance** (`FishAbundance`)
  `Very Poor / Poor / Normal / Abundant / Very Abundant` (5 options)

- [x] **Nature's Abundance** (`NatureAbundance`)
  Same 5-slot scale: `Very Poor / Poor / Normal / Abundant / Very Abundant`

---

## Meta tab

- [x] **Helicopter** (`Helicopter`)
  `Never / Once / Sometimes / Often` (4 options)

- [x] **Meta Event** (`MetaEvent`)
  `Never / Sometimes / Often` (3 options — no "Once")

---

## Character tab

- [x] **Stats Decrease** (`StatsDecrease`)
  `Very Fast / Fast / Normal / Slow / Very Slow` (5 options)

- [x] **Endurance Regeneration** (`EndRegen`)
  Same 5-slot scale: `Very Fast / Fast / Normal / Slow / Very Slow`

---

## Vehicles tab

- [x] **Vehicle Alarms Frequency** (`CarAlarm`)
  `Never / Extremely Rare / Rare / Sometimes / Often / Very Often` (6 options)

---

## Livestock tab

- [x] **Pregnancy Time** (`AnimalPregnancyTime`)
  `Ultra Fast / Very Fast / Fast / Normal / Slow / Very Slow` (6 options)

- [x] **Egg Hatch Time** (`AnimalEggHatch`)
  Same 6-slot scale (confirmed by user)

- [x] **Aging Modifier Speed** (`AnimalAgeModifier`)
  Same 6-slot scale: `Ultra Fast / Very Fast / Fast / Normal / Slow / Very Slow`
  ⚠️ **FLAG:** Sandbox.json previously showed only 3 options with Apocalypse default = index 4.
  On the actual 6-slot scale, index 4 (0-based) = **Slow**. Apocalypse default for aging is **Slow**, not Normal.
  Verify against live SandboxVars.lua before finalising.

- [x] **Milk Increase Speed** (`AnimalMilkIncModifier`)
  Same 6-slot scale (confirmed by user)

- [x] **Wool Increase Speed** (`AnimalWoolIncModifier`)
  Same 6-slot scale (confirmed by user)

- [x] **Animal Tracks Chance** (`AnimalTrackChance`)
  `Never / Extremely Rare / Rare / Sometimes / Often / Very Often` (6 options — no "Always")

- [x] **Animal Paths Chance** (`AnimalPathChance`)
  Same 6-slot scale (confirmed by user)

---

## Previously resolved (from prior session)

- [x] **Stats Reduction Speed** (`AnimalStatsModifier`) — `Ultra Fast / Very Fast / Fast / Normal / Slow / Very Slow`
- [x] **Animal Spawn Chance** (`AnimalRanchChance`) — `Never / Extremely Rare / Rare / Sometimes / Often / Very Often / Always` *(7 options — "Always" present here but NOT on Tracks/Paths)*
- [x] **Meta Stats Reduction Speed** (`AnimalMetaStatsModifier`) — NOT in UI, excluded
- [x] **Start Day** (`StartDay`) — dropdown 1–31

---

## Notes for vote tool implementation

- Population multipliers: 7-slot scale with "Insane" at top and "Custom" at bottom
- Zombie Respawn: render as two separate controls
- Gas pump amounts: 9-slot scale; both Min and Max share it
- Animal speed/time fields: all share the same 6-slot Ultra Fast→Very Slow scale
- Animal Tracks/Paths: 6-slot (no "Always"), unlike Animal Spawn Chance which has 7 (includes "Always")
- Aging Modifier Apocalypse default is likely **Slow** (index 4), not Normal — verify in live file
