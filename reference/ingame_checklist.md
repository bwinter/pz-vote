# In-game verification checklist

Settings that still need eyes on the actual PZ menu.

## Livestock tab (tab 9)

Open each dropdown and note all option labels in order.
Several are annotated with provisional labels flagged `_unverified: true` in `allowlist.json`.

- [ ] **Pregnancy Time** (`AnimalPregnancyTime`) — provisional: Ultra Fast / Very Fast / Fast / Normal / Slow / Very Slow
- [ ] **Egg Hatch Time** (`AnimalEggHatch`) — provisional: same 6-slot scale
- [ ] **Aging Modifier Speed** (`AnimalAgeModifier`) — Sandbox.json has 3 options (Very Fast / Fast / Normal) but Apocalypse default is 4 (out of range). Confirm actual options and which index is "Normal".
- [ ] **Milk Increase Speed** (`AnimalMilkIncModifier`) — provisional: same 6-slot scale
- [ ] **Wool Increase Speed** (`AnimalWoolIncModifier`) — provisional: same 6-slot scale
- [ ] **Animal Tracks Chance** (`AnimalTrackChance`) — provisional: Never / Extremely Rare / Rare / Sometimes / Often / Very Often / Always
- [ ] **Animal Paths Chance** (`AnimalPathChance`) — provisional: same 7-slot scale

## Previously resolved

- [x] **Stats Reduction Speed** (`AnimalStatsModifier`) — confirmed Ultra Fast→Very Slow (9_livestock_3.png)
- [x] **Animal Spawn Chance** (`AnimalRanchChance`) — confirmed Never→Always (9_livestock_2.png)
- [x] **Meta Stats Reduction Speed** (`AnimalMetaStatsModifier`) — NOT in UI, excluded
- [x] **Start Day** (`StartDay`) — confirmed 1-31 dropdown (1_time_2.png); rendered as number input for UX