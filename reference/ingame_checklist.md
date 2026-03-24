# In-game verification checklist

Settings confirmed as dropdowns from screenshots but with no options in Sandbox.json.
Open each dropdown and note all option labels in order.

---

## Zombie tab

- [ ] **Population Multiplier** (`PopulationMultiplier`) — provisional: Very Low/Low/Normal/High/Very High. Value shown: Normal.
- [ ] **Population Start Multiplier** (`PopulationStartMultiplier`) — provisional: same 5-slot scale. Value shown: Normal.
- [ ] **Population Peak Multiplier** (`PopulationPeakMultiplier`) — provisional: same 5-slot scale. Value shown: High.
- [ ] **Zombie Respawn** — `2_zombie_1.png` shows "Zombie Respawn: None" as a dropdown. `2_zombie_2.png` shows "Respawn Hours: 0.0" as a number in the advanced section. Unclear if these are the same control or two keys. Confirm which dropdown it is, and note all options.

## World tab (Nature settings section)

- [ ] **Temperature** (`Temperature`) — dropdown, value: Normal. No Sandbox.json options.
- [ ] **Rain** (`Rain`) — dropdown, value: Normal. No Sandbox.json options.
- [ ] **Refrigeration Effectiveness** (`FridgeFactor`) — dropdown, value: Normal. No Sandbox.json options.

## World tab (Server/World section)

- [ ] **House Alarms Frequency** (`Alarm`) — dropdown, value: Sometimes. No Sandbox.json options.
- [ ] **Locked Houses Frequency** (`LockedHouses`) — dropdown, value: Very Often. No Sandbox.json options.
- [ ] **Initial Minimum Gas Pump Amount** (`FuelStationGasMin`) — dropdown, value: Empty. No Sandbox.json options.
- [ ] **Initial Maximum Gas Pump Amount** (`FuelStationGasMax`) — dropdown, value: High. No Sandbox.json options.

## Nature tab

- [ ] **Fishing Abundance** (`FishAbundance`) — dropdown, value: Poor. No Sandbox.json options.
- [ ] **Nature's Abundance** (`NatureAbundance`) — dropdown, value: Normal. No Sandbox.json options.

## Meta tab

- [ ] **Helicopter** (`Helicopter`) — dropdown, value: Once. No Sandbox.json options.
- [ ] **Meta Event** (`MetaEvent`) — dropdown, value: Sometimes. No Sandbox.json options.

## Character tab

- [ ] **Stats Decrease** (`StatsDecrease`) — dropdown, value: Normal. No Sandbox.json options.
- [ ] **Endurance Regeneration** (`EndRegen`) — dropdown, value: Normal. No Sandbox.json options.

## Vehicles tab

- [ ] **Vehicle Alarms Frequency** (`CarAlarm`) — dropdown, value: Rare. No Sandbox.json options.

---

## Livestock tab (still open from previous pass)

- [ ] **Pregnancy Time** (`AnimalPregnancyTime`) — provisional: Ultra Fast/Very Fast/Fast/Normal/Slow/Very Slow
- [ ] **Egg Hatch Time** (`AnimalEggHatch`) — provisional: same 6-slot scale
- [ ] **Aging Modifier Speed** (`AnimalAgeModifier`) — Sandbox.json has 3 options (Very Fast/Fast/Normal) but Apocalypse def=4 is out of range. Confirm actual options and which index is "Normal".
- [ ] **Milk Increase Speed** (`AnimalMilkIncModifier`) — provisional: same 6-slot scale
- [ ] **Wool Increase Speed** (`AnimalWoolIncModifier`) — provisional: same 6-slot scale
- [ ] **Animal Tracks Chance** (`AnimalTrackChance`) — provisional: Never/Extremely Rare/Rare/Sometimes/Often/Very Often/Always
- [ ] **Animal Paths Chance** (`AnimalPathChance`) — provisional: same 7-slot scale

---

## Previously resolved

- [x] Stats Reduction Speed (`AnimalStatsModifier`) — confirmed Ultra Fast→Very Slow (9_livestock_3.png)
- [x] Animal Spawn Chance (`AnimalRanchChance`) — confirmed Never→Always (9_livestock_2.png)
- [x] Meta Stats Reduction Speed (`AnimalMetaStatsModifier`) — NOT in UI, excluded
- [x] Start Day (`StartDay`) — confirmed 1-31 dropdown (1_time_2.png); number input for UX